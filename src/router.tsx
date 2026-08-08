import { MutationCache, QueryCache, QueryClient } from "@tanstack/react-query";
import { logger } from "@/lib/logger";
import { createRouter } from "@tanstack/react-router";
import { routeTree } from "./routeTree.gen";

export const getRouter = () => {
  const queryClient = new QueryClient({
    queryCache: new QueryCache({
      onError: (error, query) => {
        logger.error({ scope: "query", event: "query_failed", queryKey: query.queryKey }, error);
      },
    }),
    mutationCache: new MutationCache({
      onError: (error, _vars, _ctx, mutation) => {
        logger.error({ scope: "query", event: "mutation_failed", mutationKey: mutation.options.mutationKey }, error);
      },
    }),
    defaultOptions: {
      queries: { staleTime: 30_000, retry: 1 },
    },
  });

  const router = createRouter({
    routeTree,
    context: { queryClient },
    scrollRestoration: true,
    defaultPreloadStaleTime: 0,
  });

  return router;
};
