import { useState } from "react";
import { createFileRoute } from "@tanstack/react-router";
import { Toaster } from "@/components/ui/sonner";
import { RnDSidebar, type RnDSectionId } from "@/components/rnd/RnDSidebar";
import { RnDTopBar } from "@/components/rnd/RnDTopBar";
import { FutureLab } from "@/components/rnd/FutureLab";
import { AIRnDAssistant } from "@/components/rnd/AIRnDAssistant";
import { AIIdeaScorer } from "@/components/rnd/AIIdeaScorer";
import { TechnologyRadar } from "@/components/rnd/TechnologyRadar";
import { InnovationPipeline } from "@/components/rnd/InnovationPipeline";
import { PrototypeBuilder } from "@/components/rnd/PrototypeBuilder";
import { ImpactAnalyzer } from "@/components/rnd/ImpactAnalyzer";
import { TrendScanner } from "@/components/rnd/TrendScanner";
import { FeedbackPortal } from "@/components/rnd/FeedbackPortal";
import { DecisionBoard } from "@/components/rnd/DecisionBoard";
import { RnDWallet } from "@/components/rnd/RnDWallet";
import { RnDNotifications } from "@/components/rnd/RnDNotifications";
import {
  useDecisions,
  useIdeas,
  useNotifications,
  usePrototypes,
  useTrends,
} from "@/hooks/useRnDData";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "R&D Dashboard — Software Vala" },
      {
        name: "description",
        content:
          "Software Vala R&D command center: idea intake, AI evaluation, prototypes, trends, decisions and research budget in one workspace.",
      },
      { property: "og:title", content: "R&D Dashboard — Software Vala" },
      {
        property: "og:description",
        content: "Innovation pipeline, AI research assistant and live R&D analytics for Software Vala.",
      },
    ],
  }),
  component: RnDDashboard,
});

function RnDDashboard() {
  const [activeTab, setActiveTab] = useState<RnDSectionId>("future-lab");
  const [search, setSearch] = useState("");

  const { data: ideas } = useIdeas();
  const { data: prototypes } = usePrototypes();
  const { data: trends } = useTrends();
  const { data: decisions } = useDecisions();
  const { data: notifications } = useNotifications();

  const unread = (notifications ?? []).filter((item) => !item.read).length;

  return (
    <div className="flex min-h-screen">
      <RnDSidebar activeTab={activeTab} onTabChange={setActiveTab} unreadCount={unread} />
      <div className="flex min-w-0 flex-1 flex-col">
        <RnDTopBar
          activeTab={activeTab}
          onTabChange={setActiveTab}
          search={search}
          onSearchChange={setSearch}
          stats={{
            ideas: ideas?.length ?? 0,
            prototypes: prototypes?.length ?? 0,
            trends: trends?.length ?? 0,
            decisions: decisions?.length ?? 0,
          }}
        />
        <main className="flex-1 p-6">
          <h1 className="sr-only">Software Vala R&amp;D Dashboard</h1>
          {activeTab === "future-lab" && <FutureLab search={search} />}
          {activeTab === "ai-assistant" && <AIRnDAssistant />}
          {activeTab === "idea-scorer" && <AIIdeaScorer />}
          {activeTab === "tech-radar" && <TechnologyRadar />}
          {activeTab === "pipeline" && <InnovationPipeline />}
          {activeTab === "prototype" && <PrototypeBuilder />}
          {activeTab === "impact" && <ImpactAnalyzer />}
          {activeTab === "trends" && <TrendScanner />}
          {activeTab === "feedback" && <FeedbackPortal />}
          {activeTab === "decisions" && <DecisionBoard />}
          {activeTab === "wallet" && <RnDWallet />}
          {activeTab === "notifications" && <RnDNotifications />}
        </main>
      </div>
      <Toaster />
    </div>
  );
}
