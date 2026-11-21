import { useInfiniteQuery, useQuery, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import type {
  Budget,
  Decision,
  Feedback,
  Idea,
  IdeaEvaluation,
  ImpactAnalysis,
  MarketGap,
  PipelineItem,
  Prototype,
  RnDNotification,
  Technology,
  Transaction,
  Trend,
} from "@/lib/rnd-types";

type RnDTable =
  | "rnd_ideas"
  | "rnd_prototypes"
  | "rnd_impact_analyses"
  | "rnd_trends"
  | "rnd_market_gaps"
  | "rnd_feedback"
  | "rnd_decisions"
  | "rnd_technologies"
  | "rnd_pipeline_items"
  | "rnd_transactions";

/** Hard cap on non-paginated reads so a large table can never flood the client. */
export const RND_MAX_ROWS = 200;
/** Rows fetched per page by the paginated idea list. */
export const RND_PAGE_SIZE = 30;

async function selectAll<T>(
  table: RnDTable,
  order: string,
  ascending = false,
  limit: number = RND_MAX_ROWS,
): Promise<T[]> {
  const { data, error } = await supabase
    .from(table)
    .select("*")
    .order(order, { ascending })
    .limit(limit);
  if (error) throw new Error(error.message);
  return (data ?? []) as T[];
}

export const rndKeys = {
  ideas: ["rnd", "ideas"] as const,
  prototypes: ["rnd", "prototypes"] as const,
  impact: ["rnd", "impact"] as const,
  trends: ["rnd", "trends"] as const,
  gaps: ["rnd", "gaps"] as const,
  feedback: ["rnd", "feedback"] as const,
  decisions: ["rnd", "decisions"] as const,
  notifications: ["rnd", "notifications"] as const,
  budget: ["rnd", "budget"] as const,
  transactions: ["rnd", "transactions"] as const,
  technologies: ["rnd", "technologies"] as const,
  pipeline: ["rnd", "pipeline"] as const,
};

export const useIdeas = () =>
  useQuery({ queryKey: rndKeys.ideas, queryFn: () => selectAll<Idea>("rnd_ideas", "created_at") });

/** Paginated idea feed for Future Lab. Filters by category server-side when set. */
export const useIdeasPaged = (category: string) => {
  const query = useInfiniteQuery({
    queryKey: [...rndKeys.ideas, "paged", category],
    initialPageParam: 0,
    queryFn: async ({ pageParam }) => {
      const from = pageParam * RND_PAGE_SIZE;
      let request = supabase
        .from("rnd_ideas")
        .select("*", { count: "exact" })
        .order("created_at", { ascending: false })
        .range(from, from + RND_PAGE_SIZE - 1);
      if (category !== "all") request = request.eq("category", category);
      const { data, error, count } = await request;
      if (error) throw new Error(error.message);
      return { rows: (data ?? []) as Idea[], page: pageParam, total: count ?? 0 };
    },
    getNextPageParam: (last) => ((last.page + 1) * RND_PAGE_SIZE < last.total ? last.page + 1 : undefined),
  });

  return {
    ideas: (query.data?.pages ?? []).flatMap((entry) => entry.rows),
    total: query.data?.pages?.[0]?.total ?? 0,
    isLoading: query.isLoading,
    hasNextPage: query.hasNextPage,
    isFetchingNextPage: query.isFetchingNextPage,
    fetchNextPage: () => void query.fetchNextPage(),
  };
};

export const usePrototypes = () =>
  useQuery({ queryKey: rndKeys.prototypes, queryFn: () => selectAll<Prototype>("rnd_prototypes", "created_at") });

export const useImpactAnalyses = () =>
  useQuery({ queryKey: rndKeys.impact, queryFn: () => selectAll<ImpactAnalysis>("rnd_impact_analyses", "created_at") });

export const useIdeaEvaluations = () =>
  useQuery({ queryKey: ["rnd", "idea-evaluations"], queryFn: () => selectAll<IdeaEvaluation>("rnd_idea_evaluations", "created_at") });

export type RnDAiMessage = {
  id: string;
  session_id: string;
  role: "user" | "assistant";
  content: string;
  created_at: string;
};

export const useAiMessages = (sessionId: string | null) =>
  useQuery({
    queryKey: ["rnd", "ai-messages", sessionId],
    enabled: Boolean(sessionId),
    queryFn: async () => {
      if (!sessionId) return [];
      const { data, error } = await supabase
        .from("rnd_ai_messages")
        .select("id, session_id, role, content, created_at")
        .eq("session_id", sessionId)
        .order("created_at", { ascending: true })
        .limit(RND_MAX_ROWS);
      if (error) throw new Error(error.message);
      return (data ?? []) as RnDAiMessage[];
    },
  });

export const useTrends = () =>
  useQuery({ queryKey: rndKeys.trends, queryFn: () => selectAll<Trend>("rnd_trends", "detected_at") });

export const useMarketGaps = () =>
  useQuery({ queryKey: rndKeys.gaps, queryFn: () => selectAll<MarketGap>("rnd_market_gaps", "created_at") });

export const useFeedback = () =>
  useQuery({ queryKey: rndKeys.feedback, queryFn: () => selectAll<Feedback>("rnd_feedback", "created_at") });

export const useDecisions = () =>
  useQuery({ queryKey: rndKeys.decisions, queryFn: () => selectAll<Decision>("rnd_decisions", "submitted_at") });

export const useNotifications = () =>
  useQuery({
    queryKey: rndKeys.notifications,
    queryFn: async () => {
      const { data, error } = await supabase
        .from("rnd_notifications")
        .select("*")
        .eq("dismissed", false)
        .order("created_at", { ascending: false });
      if (error) throw new Error(error.message);
      return (data ?? []) as RnDNotification[];
    },
    refetchInterval: 60_000,
  });

export const useBudget = () =>
  useQuery({
    queryKey: rndKeys.budget,
    queryFn: async () => {
      const { data, error } = await supabase.from("rnd_budgets").select("*").eq("is_current", true).limit(1);
      if (error) throw new Error(error.message);
      return ((data ?? [])[0] ?? null) as Budget | null;
    },
  });

export const useTransactions = () =>
  useQuery({ queryKey: rndKeys.transactions, queryFn: () => selectAll<Transaction>("rnd_transactions", "occurred_on") });

export const useTechnologies = () =>
  useQuery({ queryKey: rndKeys.technologies, queryFn: () => selectAll<Technology>("rnd_technologies", "relevance") });

export const usePipeline = () =>
  useQuery({ queryKey: rndKeys.pipeline, queryFn: () => selectAll<PipelineItem>("rnd_pipeline_items", "created_at") });

export const useInvalidateRnD = () => {
  const queryClient = useQueryClient();
  return (key: readonly unknown[]) => queryClient.invalidateQueries({ queryKey: key });
};