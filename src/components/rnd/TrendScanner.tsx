import { useEffect, useState } from "react";
import { useServerFn } from "@tanstack/react-start";
import { toast } from "sonner";
import { AlertCircle, ArrowUpRight, CheckCircle, Clock, Globe, Loader2, Plus, Target, TrendingUp, Zap } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useRnDAI } from "@/hooks/useRnDAI";
import { rndKeys, useAiMessages, useInvalidateRnD, useMarketGaps, useTrends } from "@/hooks/useRnDData";
import { saveChatMessage, saveMarketGap, saveTrend, updateTrendStatus } from "@/lib/rnd-data.functions";
import type { MarketGap, Trend } from "@/lib/rnd-types";

const analysisSession = "trend-scanner-analysis";
const statuses = ["emerging", "growing", "established", "declining"] as const;
const levels = ["low", "medium", "high"] as const;

const impactTone: Record<string, string> = {
  high: "border-danger/40 text-danger",
  medium: "border-warning/40 text-warning",
  low: "border-border text-muted-foreground",
};

const statusIcon = (status: string) => {
  if (status === "emerging") return <Zap className="h-3.5 w-3.5" />;
  if (status === "growing") return <TrendingUp className="h-3.5 w-3.5" />;
  if (status === "established") return <CheckCircle className="h-3.5 w-3.5" />;
  return <ArrowUpRight className="h-3.5 w-3.5" />;
};

export const TrendScanner = () => {
  const invalidate = useInvalidateRnD();
  const { data: trends = [], isLoading: trendsLoading, error: trendsError } = useTrends();
  const { data: gaps = [], isLoading: gapsLoading, error: gapsError } = useMarketGaps();
  const { data: savedAnalysis = [] } = useAiMessages(analysisSession);
  const { isLoading: aiLoading, chat } = useRnDAI();
  const persistMessage = useServerFn(saveChatMessage);
  const createTrend = useServerFn(saveTrend);
  const changeTrendStatus = useServerFn(updateTrendStatus);
  const createGap = useServerFn(saveMarketGap);
  const [showTrendForm, setShowTrendForm] = useState(false);
  const [showGapForm, setShowGapForm] = useState(false);
  const [analysis, setAnalysis] = useState("");
  const [saving, setSaving] = useState(false);
  const [trendForm, setTrendForm] = useState({
    title: "",
    source: "",
    impact: "medium",
    relevance: "50",
    status: "emerging",
    competitors: "",
    opportunity: "",
  });
  const [gapForm, setGapForm] = useState({ gap: "", potential: "medium", difficulty: "medium" });

  useEffect(() => {
    const latest = [...savedAnalysis].reverse().find((message) => message.role === "assistant");
    setAnalysis(latest?.content ?? "");
  }, [savedAnalysis]);

  const handleAnalyze = async () => {
    if (!trends.length && !gaps.length) {
      toast.error("There are no saved trends or gaps to analyze yet");
      return;
    }
    const prompt = `Review only these saved R&D market records. Separate observations from assumptions, do not invent current market facts, and recommend next actions.\n\nSaved trends:\n${JSON.stringify(trends)}\n\nSaved market gaps:\n${JSON.stringify(gaps)}`;
    try {
      await persistMessage({ data: { session_id: analysisSession, role: "user", content: prompt } });
      const result = await chat(prompt, "Analysis of persisted R&D trends and market gaps");
      if (!result) return;
      await persistMessage({ data: { session_id: analysisSession, role: "assistant", content: result } });
      await invalidate(["rnd", "ai-messages", analysisSession]);
      toast.success("Analysis saved");
    } catch (error) {
      toast.error("Could not save the analysis", { description: error instanceof Error ? error.message : undefined });
    }
  };

  const handleTrendSave = async () => {
    const relevance = Number(trendForm.relevance);
    if (trendForm.title.trim().length < 3 || trendForm.source.trim().length < 2 || !Number.isInteger(relevance) || relevance < 0 || relevance > 100) {
      toast.error("Enter a title, source, and relevance from 0 to 100");
      return;
    }
    setSaving(true);
    try {
      await createTrend({ data: {
        ...trendForm,
        title: trendForm.title.trim(),
        source: trendForm.source.trim(),
        impact: trendForm.impact as (typeof levels)[number],
        relevance,
        status: trendForm.status as (typeof statuses)[number],
        competitors: trendForm.competitors.split(",").map((name) => name.trim()).filter(Boolean),
        opportunity: trendForm.opportunity.trim(),
      } });
      await invalidate(rndKeys.trends);
      setTrendForm({ title: "", source: "", impact: "medium", relevance: "50", status: "emerging", competitors: "", opportunity: "" });
      setShowTrendForm(false);
      toast.success("Trend saved");
    } catch (error) {
      toast.error("Could not save trend", { description: error instanceof Error ? error.message : undefined });
    } finally {
      setSaving(false);
    }
  };

  const handleGapSave = async () => {
    if (gapForm.gap.trim().length < 5) {
      toast.error("Describe the market gap first");
      return;
    }
    setSaving(true);
    try {
      await createGap({ data: {
        gap: gapForm.gap.trim(),
        potential: gapForm.potential as (typeof levels)[number],
        difficulty: gapForm.difficulty as (typeof levels)[number],
      } });
      await invalidate(rndKeys.gaps);
      setGapForm({ gap: "", potential: "medium", difficulty: "medium" });
      setShowGapForm(false);
      toast.success("Market gap saved");
    } catch (error) {
      toast.error("Could not save market gap", { description: error instanceof Error ? error.message : undefined });
    } finally {
      setSaving(false);
    }
  };

  const handleStatusChange = async (trend: Trend, status: (typeof statuses)[number]) => {
    try {
      await changeTrendStatus({ data: { id: trend.id, status } });
      await invalidate(rndKeys.trends);
      toast.success("Trend status updated");
    } catch (error) {
      toast.error("Could not update trend status", { description: error instanceof Error ? error.message : undefined });
    }
  };

  return (
    <div className="space-y-6">
      <header className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h2 className="brand-gradient-text font-display text-2xl font-bold">Trend &amp; Competitor Scanner</h2>
          <p className="mt-1 text-sm text-muted-foreground">Saved market signals and opportunities</p>
        </div>
        <div className="flex flex-wrap gap-2">
          <Button variant="outline" onClick={() => setShowGapForm((open) => !open)}><Plus className="mr-2 h-4 w-4" />Market gap</Button>
          <Button variant="outline" onClick={() => setShowTrendForm((open) => !open)}><Plus className="mr-2 h-4 w-4" />Trend</Button>
          <Button onClick={handleAnalyze} disabled={aiLoading || trendsLoading || gapsLoading}>
            {aiLoading ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Globe className="mr-2 h-4 w-4" />}
            Analyze saved records
          </Button>
        </div>
      </header>

      <Card className="panel flex flex-wrap items-center justify-between gap-3 p-4">
        <div className="flex items-center gap-3">
          <span className="grid h-9 w-9 place-items-center rounded-lg brand-soft text-brand-2"><TrendingUp className="h-4 w-4" /></span>
          <div>
            <p className="text-sm font-medium text-foreground">Live record counts</p>
            <p className="text-xs text-muted-foreground">{trends.length} trends · {gaps.length} market gaps</p>
          </div>
        </div>
        <p className="text-xs text-muted-foreground">AI analysis is based on saved records</p>
      </Card>

      {showTrendForm && (
        <Card className="panel space-y-3 p-4">
          <div className="grid gap-3 md:grid-cols-2">
            <Input aria-label="Trend title" placeholder="Trend title" value={trendForm.title} onChange={(event) => setTrendForm({ ...trendForm, title: event.target.value })} />
            <Input aria-label="Trend source" placeholder="Source" value={trendForm.source} onChange={(event) => setTrendForm({ ...trendForm, source: event.target.value })} />
            <Input aria-label="Competitors" placeholder="Competitors, separated by commas" value={trendForm.competitors} onChange={(event) => setTrendForm({ ...trendForm, competitors: event.target.value })} />
            <Input aria-label="Relevance score" type="number" min="0" max="100" placeholder="Relevance (0–100)" value={trendForm.relevance} onChange={(event) => setTrendForm({ ...trendForm, relevance: event.target.value })} />
            <Select value={trendForm.impact} onValueChange={(impact) => setTrendForm({ ...trendForm, impact })}>
              <SelectTrigger aria-label="Impact"><SelectValue placeholder="Impact" /></SelectTrigger>
              <SelectContent>{levels.map((level) => <SelectItem key={level} value={level}>{level} impact</SelectItem>)}</SelectContent>
            </Select>
            <Select value={trendForm.status} onValueChange={(status) => setTrendForm({ ...trendForm, status })}>
              <SelectTrigger aria-label="Initial status"><SelectValue placeholder="Status" /></SelectTrigger>
              <SelectContent>{statuses.map((status) => <SelectItem key={status} value={status}>{status}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <Textarea aria-label="Opportunity" placeholder="Opportunity or implication" value={trendForm.opportunity} onChange={(event) => setTrendForm({ ...trendForm, opportunity: event.target.value })} />
          <div className="flex justify-end gap-2"><Button variant="ghost" onClick={() => setShowTrendForm(false)}>Cancel</Button><Button onClick={handleTrendSave} disabled={saving}>{saving && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}Save trend</Button></div>
        </Card>
      )}

      {showGapForm && (
        <Card className="panel space-y-3 p-4">
          <Textarea aria-label="Market gap" placeholder="Describe the unmet need" value={gapForm.gap} onChange={(event) => setGapForm({ ...gapForm, gap: event.target.value })} />
          <div className="grid gap-3 sm:grid-cols-2">
            <Select value={gapForm.potential} onValueChange={(potential) => setGapForm({ ...gapForm, potential })}>
              <SelectTrigger aria-label="Market potential"><SelectValue placeholder="Potential" /></SelectTrigger>
              <SelectContent>{levels.map((level) => <SelectItem key={level} value={level}>{level} potential</SelectItem>)}</SelectContent>
            </Select>
            <Select value={gapForm.difficulty} onValueChange={(difficulty) => setGapForm({ ...gapForm, difficulty })}>
              <SelectTrigger aria-label="Difficulty"><SelectValue placeholder="Difficulty" /></SelectTrigger>
              <SelectContent>{levels.map((level) => <SelectItem key={level} value={level}>{level} difficulty</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="flex justify-end gap-2"><Button variant="ghost" onClick={() => setShowGapForm(false)}>Cancel</Button><Button onClick={handleGapSave} disabled={saving}>{saving && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}Save gap</Button></div>
        </Card>
      )}

      {(trendsError || gapsError) && <Card className="border-danger/40 p-4 text-sm text-danger">Could not load saved market records. Please try again.</Card>}

      <div className="grid gap-6 xl:grid-cols-2">
        <section className="space-y-4">
          <h3 className="flex items-center gap-2 font-display text-lg font-semibold"><TrendingUp className="h-5 w-5 text-brand-2" />Trends</h3>
          {trendsLoading ? <Card className="panel p-6 text-sm text-muted-foreground">Loading saved trends…</Card> : trends.length === 0 ? <Card className="panel p-6 text-sm text-muted-foreground">No trends saved yet.</Card> : trends.map((trend) => <TrendCard key={trend.id} trend={trend} onStatusChange={handleStatusChange} />)}
        </section>

        <section className="space-y-4">
          <h3 className="flex items-center gap-2 font-display text-lg font-semibold"><Target className="h-5 w-5 text-success" />Market gaps</h3>
          {gapsLoading ? <Card className="panel p-6 text-sm text-muted-foreground">Loading saved gaps…</Card> : gaps.length === 0 ? <Card className="panel p-6 text-sm text-muted-foreground">No market gaps saved yet.</Card> : gaps.map((gap) => <GapCard key={gap.id} gap={gap} />)}
          {analysis && <Card className="panel space-y-3 p-4"><div className="flex items-center gap-2 font-semibold text-foreground"><Zap className="h-4 w-4 text-brand" />Latest AI review</div><p className="whitespace-pre-wrap text-sm text-muted-foreground">{analysis}</p></Card>}
        </section>
      </div>
    </div>
  );
};

function TrendCard({ trend, onStatusChange }: { trend: Trend; onStatusChange: (trend: Trend, status: (typeof statuses)[number]) => void }) {
  return (
    <Card className="panel space-y-4 p-4">
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div className="min-w-0">
          <h4 className="font-semibold text-foreground">{trend.title}</h4>
          <p className="mt-1 flex items-center gap-2 text-xs text-muted-foreground"><span>{trend.source}</span><span aria-hidden="true">·</span><span><Clock className="mr-1 inline h-3 w-3" />{new Date(trend.detected_at).toLocaleDateString()}</span></p>
        </div>
        <Select value={trend.status} onValueChange={(status) => onStatusChange(trend, status as (typeof statuses)[number])}>
          <SelectTrigger aria-label={`Status for ${trend.title}`} className="h-8 w-36"><SelectValue /></SelectTrigger>
          <SelectContent>{statuses.map((status) => <SelectItem key={status} value={status}>{statusIcon(status)}<span className="ml-2">{status}</span></SelectItem>)}</SelectContent>
        </Select>
      </div>
      <div className="flex flex-wrap items-center gap-2">
        <Badge variant="outline" className={impactTone[trend.impact] ?? impactTone.low}>{trend.impact} impact</Badge>
        <Badge variant="outline" className="border-border text-muted-foreground">{trend.relevance}% relevance</Badge>
      </div>
      <div className="h-1.5 overflow-hidden rounded-full bg-surface-2"><div className="h-full rounded-full bg-brand-2" style={{ width: `${Math.max(0, Math.min(100, trend.relevance))}%` }} /></div>
      {trend.competitors.length > 0 && <p className="text-xs text-muted-foreground">Competitors: {trend.competitors.join(", ")}</p>}
      {trend.opportunity && <p className="flex items-start gap-2 text-sm text-foreground"><AlertCircle className="mt-0.5 h-4 w-4 shrink-0 text-success" />{trend.opportunity}</p>}
    </Card>
  );
}

function GapCard({ gap }: { gap: MarketGap }) {
  return (
    <Card className="panel flex items-start gap-3 p-4">
      <span className="grid h-9 w-9 shrink-0 place-items-center rounded-lg bg-success/10 text-success"><Target className="h-4 w-4" /></span>
      <div className="min-w-0 flex-1 space-y-3">
        <p className="text-sm text-foreground">{gap.gap}</p>
        <div className="flex flex-wrap gap-2"><Badge variant="outline" className={impactTone[gap.potential] ?? impactTone.low}>Potential: {gap.potential}</Badge><Badge variant="outline" className="border-border text-muted-foreground">Difficulty: {gap.difficulty}</Badge></div>
      </div>
    </Card>
  );
}