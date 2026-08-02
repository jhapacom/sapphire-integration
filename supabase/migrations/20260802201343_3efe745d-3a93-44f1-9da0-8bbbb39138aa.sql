
CREATE TABLE public.rnd_ideas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL DEFAULT '',
  category text NOT NULL DEFAULT 'ai',
  priority text NOT NULL DEFAULT 'medium',
  feasibility integer NOT NULL DEFAULT 0,
  author text NOT NULL DEFAULT 'vala(rnd)0000',
  votes integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'evaluating',
  research_links integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_ideas TO anon, authenticated;
GRANT ALL ON public.rnd_ideas TO service_role;
ALTER TABLE public.rnd_ideas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_ideas_public_read" ON public.rnd_ideas FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_prototypes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  modules text[] NOT NULL DEFAULT '{}',
  progress integer NOT NULL DEFAULT 0,
  estimated_hours integer NOT NULL DEFAULT 0,
  completed_hours integer NOT NULL DEFAULT 0,
  team text[] NOT NULL DEFAULT '{}',
  status text NOT NULL DEFAULT 'active',
  integrations text[] NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_prototypes TO anon, authenticated;
GRANT ALL ON public.rnd_prototypes TO service_role;
ALTER TABLE public.rnd_prototypes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_prototypes_public_read" ON public.rnd_prototypes FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_impact_analyses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  feature text NOT NULL,
  revenue_impact text NOT NULL DEFAULT 'medium',
  effort_level text NOT NULL DEFAULT 'medium',
  technical_risk text NOT NULL DEFAULT 'low',
  user_demand integer NOT NULL DEFAULT 0,
  performance_load integer NOT NULL DEFAULT 0,
  maintenance_cost text NOT NULL DEFAULT 'low',
  ai_recommendation text NOT NULL DEFAULT '',
  score_revenue integer NOT NULL DEFAULT 0,
  score_effort integer NOT NULL DEFAULT 0,
  score_risk integer NOT NULL DEFAULT 0,
  score_demand integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_impact_analyses TO anon, authenticated;
GRANT ALL ON public.rnd_impact_analyses TO service_role;
ALTER TABLE public.rnd_impact_analyses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_impact_public_read" ON public.rnd_impact_analyses FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_trends (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  source text NOT NULL DEFAULT 'Industry Analysis',
  impact text NOT NULL DEFAULT 'medium',
  relevance integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'emerging',
  competitors text[] NOT NULL DEFAULT '{}',
  opportunity text NOT NULL DEFAULT '',
  detected_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_trends TO anon, authenticated;
GRANT ALL ON public.rnd_trends TO service_role;
ALTER TABLE public.rnd_trends ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_trends_public_read" ON public.rnd_trends FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_market_gaps (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  gap text NOT NULL,
  potential text NOT NULL DEFAULT 'medium',
  difficulty text NOT NULL DEFAULT 'medium',
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_market_gaps TO anon, authenticated;
GRANT ALL ON public.rnd_market_gaps TO service_role;
ALTER TABLE public.rnd_market_gaps ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_gaps_public_read" ON public.rnd_market_gaps FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_feedback (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  content text NOT NULL,
  source text NOT NULL DEFAULT 'survey',
  sentiment text NOT NULL DEFAULT 'neutral',
  sentiment_score numeric NOT NULL DEFAULT 0,
  category text NOT NULL DEFAULT 'feature_request',
  votes integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'in_review',
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_feedback TO anon, authenticated;
GRANT ALL ON public.rnd_feedback TO service_role;
ALTER TABLE public.rnd_feedback ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_feedback_public_read" ON public.rnd_feedback FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_decisions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  type text NOT NULL DEFAULT 'feature',
  status text NOT NULL DEFAULT 'pending',
  submitted_by text NOT NULL DEFAULT 'vala(rnd)0000',
  submitted_at timestamptz NOT NULL DEFAULT now(),
  ai_score integer NOT NULL DEFAULT 0,
  votes_approve integer NOT NULL DEFAULT 0,
  votes_reject integer NOT NULL DEFAULT 0,
  votes_hold integer NOT NULL DEFAULT 0,
  estimated_cost integer NOT NULL DEFAULT 0,
  estimated_time text NOT NULL DEFAULT '',
  priority text NOT NULL DEFAULT 'medium'
);
GRANT SELECT ON public.rnd_decisions TO anon, authenticated;
GRANT ALL ON public.rnd_decisions TO service_role;
ALTER TABLE public.rnd_decisions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_decisions_public_read" ON public.rnd_decisions FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type text NOT NULL DEFAULT 'idea',
  title text NOT NULL,
  message text NOT NULL DEFAULT '',
  read boolean NOT NULL DEFAULT false,
  dismissed boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_notifications TO anon, authenticated;
GRANT ALL ON public.rnd_notifications TO service_role;
ALTER TABLE public.rnd_notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_notifications_public_read" ON public.rnd_notifications FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_budgets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  period text NOT NULL,
  total_budget integer NOT NULL DEFAULT 0,
  currency text NOT NULL DEFAULT 'USD',
  is_current boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_budgets TO anon, authenticated;
GRANT ALL ON public.rnd_budgets TO service_role;
ALTER TABLE public.rnd_budgets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_budgets_public_read" ON public.rnd_budgets FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  budget_id uuid NOT NULL REFERENCES public.rnd_budgets(id) ON DELETE CASCADE,
  description text NOT NULL,
  amount integer NOT NULL,
  type text NOT NULL DEFAULT 'deduction',
  status text NOT NULL DEFAULT 'completed',
  occurred_on date NOT NULL DEFAULT current_date,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_transactions TO anon, authenticated;
GRANT ALL ON public.rnd_transactions TO service_role;
ALTER TABLE public.rnd_transactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_transactions_public_read" ON public.rnd_transactions FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_technologies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  category text NOT NULL DEFAULT 'tools',
  ring text NOT NULL DEFAULT 'assess',
  description text NOT NULL DEFAULT '',
  relevance integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_technologies TO anon, authenticated;
GRANT ALL ON public.rnd_technologies TO service_role;
ALTER TABLE public.rnd_technologies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_tech_public_read" ON public.rnd_technologies FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_pipeline_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL DEFAULT '',
  stage text NOT NULL DEFAULT 'ideation',
  progress integer NOT NULL DEFAULT 0,
  priority text NOT NULL DEFAULT 'medium',
  assignee text NOT NULL DEFAULT 'vala(rnd)0000',
  due_date date,
  ai_score integer,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_pipeline_items TO anon, authenticated;
GRANT ALL ON public.rnd_pipeline_items TO service_role;
ALTER TABLE public.rnd_pipeline_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_pipeline_public_read" ON public.rnd_pipeline_items FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_idea_evaluations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL DEFAULT '',
  category text NOT NULL DEFAULT 'General',
  scores jsonb NOT NULL DEFAULT '{}'::jsonb,
  ai_analysis text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_idea_evaluations TO anon, authenticated;
GRANT ALL ON public.rnd_idea_evaluations TO service_role;
ALTER TABLE public.rnd_idea_evaluations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_evaluations_public_read" ON public.rnd_idea_evaluations FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.rnd_ai_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id text NOT NULL,
  role text NOT NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.rnd_ai_messages TO anon, authenticated;
GRANT ALL ON public.rnd_ai_messages TO service_role;
ALTER TABLE public.rnd_ai_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "rnd_ai_messages_public_read" ON public.rnd_ai_messages FOR SELECT TO anon, authenticated USING (true);

-- Seed data (realistic R&D operating records)
INSERT INTO public.rnd_ideas (title, description, category, priority, feasibility, author, votes, status, research_links, created_at) VALUES
('AI-Powered Code Review Assistant','Automated code review with AI suggestions for optimization and security.','ai','high',87,'vala(rnd)2341',24,'evaluating',3, now() - interval '2 hours'),
('Holographic Dashboard Widgets','3D holographic-style widgets with depth perception and parallax effects.','uiux','medium',72,'vala(design)8892',18,'approved',5, now() - interval '5 hours'),
('One-Click Deployment Pipeline','Simplified deployment with automated testing, staging, and production rollout.','devtools','high',94,'vala(dev)4412',31,'in_prototype',2, now() - interval '1 day'),
('Predictive Client Needs Engine','AI predicts client needs before they ask, enabling proactive support.','client','medium',68,'vala(cs)7723',15,'evaluating',4, now() - interval '3 days'),
('Auto-Scaling Task Automation','Intelligent task distribution that scales based on team capacity.','automation','critical',81,'vala(rnd)2341',27,'approved',6, now() - interval '4 hours'),
('Unified Design Token Pipeline','Single source of truth for tokens synced across web, mobile and docs.','uiux','medium',76,'vala(design)8892',12,'evaluating',2, now() - interval '2 days'),
('Self-Healing Integration Monitor','Detects failing third-party integrations and applies automated recovery.','automation','high',79,'vala(devops)3341',21,'in_prototype',4, now() - interval '6 hours'),
('Client Onboarding Copilot','Guided AI onboarding that configures workspaces from a short interview.','client','high',84,'vala(cs)7723',19,'approved',3, now() - interval '8 hours');

INSERT INTO public.rnd_prototypes (name, modules, progress, estimated_hours, completed_hours, team, status, integrations) VALUES
('Neural Code Assistant v2', ARRAY['AI Engine','Code Parser','Suggestion API','UI Widget'],78,120,94, ARRAY['vala(dev)4412','vala(rnd)2341','vala(ai)9981'],'active', ARRAY['VS Code','GitHub','Slack']),
('Holographic Dashboard', ARRAY['3D Renderer','Widget System','Animation Engine'],45,200,90, ARRAY['vala(design)8892','vala(dev)5523'],'active', ARRAY['React','Three.js','Framer']),
('Smart Deployment Pipeline', ARRAY['CI/CD Core','Test Runner','Environment Manager','Rollback System'],92,80,74, ARRAY['vala(devops)3341','vala(dev)4412'],'testing', ARRAY['Docker','K8s','AWS']),
('Predictive Support Engine', ARRAY['Signal Collector','Scoring Model','Alert Router'],38,160,61, ARRAY['vala(ai)9981','vala(cs)7723'],'active', ARRAY['Zendesk','Segment','Postgres']);

INSERT INTO public.rnd_impact_analyses (feature, revenue_impact, effort_level, technical_risk, user_demand, performance_load, maintenance_cost, ai_recommendation, score_revenue, score_effort, score_risk, score_demand) VALUES
('AI-Powered Code Review','high','medium','low',89,34,'low','Strongly recommended. High ROI with manageable effort.',92,65,23,89),
('Holographic Dashboard','medium','high','medium',67,78,'medium','Consider phased implementation. Visual appeal may drive adoption.',68,85,56,67),
('One-Click Deployment','high','low','low',95,12,'low','Priority implementation. Developer productivity boost confirmed.',88,35,18,95),
('Predictive Client Needs Engine','high','high','medium',74,52,'medium','Run a limited pilot with two enterprise accounts before scaling.',81,80,49,74);

INSERT INTO public.rnd_trends (title, source, impact, relevance, status, competitors, opportunity, detected_at) VALUES
('AI-Powered Development Tools','Industry Analysis','high',94,'emerging', ARRAY['GitHub Copilot','Cursor','Tabnine'],'Integrate AI code completion with our unique workflow context', now() - interval '2 hours'),
('Low-Code Backend Solutions','Market Research','medium',78,'growing', ARRAY['Supabase','Firebase','PlanetScale'],'Visual database designer with AI-generated schemas', now() - interval '6 hours'),
('Real-Time Collaboration Features','User Feedback','high',89,'established', ARRAY['Figma','Linear','Notion'],'Multi-cursor editing with presence indicators', now() - interval '1 day'),
('Edge-First Application Delivery','Industry Analysis','medium',71,'growing', ARRAY['Cloudflare','Vercel','Fastly'],'Move latency-sensitive dashboard reads to the edge', now() - interval '2 days'),
('Autonomous QA Agents','Market Research','high',83,'emerging', ARRAY['Testim','Mabl','QA Wolf'],'Self-writing regression suites tied to our release pipeline', now() - interval '9 hours');

INSERT INTO public.rnd_market_gaps (gap, potential, difficulty) VALUES
('No major player offers AI-driven project estimation','high','medium'),
('Limited visual debugging tools in market','medium','high'),
('Lack of unified analytics across dev lifecycle','high','low'),
('No cross-tool migration assistant for growing teams','medium','medium');

INSERT INTO public.rnd_feedback (content, source, sentiment, sentiment_score, category, votes, status, created_at) VALUES
('The deployment process takes too long. Need faster CI/CD.','support_ticket','negative',-0.78,'pain_point',34,'actionable', now() - interval '2 hours'),
('Would love to have dark mode for the entire dashboard.','survey','positive',0.65,'feature_request',89,'in_review', now() - interval '1 day'),
('Mobile responsiveness needs improvement on lead manager.','chat_log','negative',-0.45,'pain_point',23,'actionable', now() - interval '3 days'),
('AI suggestions for task assignments are incredibly helpful!','survey','positive',0.92,'praise',56,'noted', now() - interval '5 hours'),
('Need bulk actions for lead management - very time consuming currently.','support_ticket','negative',-0.62,'feature_request',67,'in_review', now() - interval '12 hours'),
('Reporting exports are clear and fast now, big improvement.','chat_log','positive',0.71,'praise',18,'noted', now() - interval '2 days');

INSERT INTO public.rnd_decisions (title, type, status, submitted_by, submitted_at, ai_score, votes_approve, votes_reject, votes_hold, estimated_cost, estimated_time, priority) VALUES
('AI Code Review Assistant','feature','pending','vala(rnd)2341', now() - interval '2 days',92,5,1,0,12500,'3 weeks','high'),
('Holographic Dashboard Widgets','enhancement','pending','vala(design)8892', now() - interval '4 days',72,3,2,1,28000,'6 weeks','medium'),
('One-Click Deployment Pipeline','feature','approved','vala(devops)3341', now() - interval '7 days',94,6,0,0,8200,'2 weeks','critical'),
('Legacy API Deprecation','technical','on_hold','vala(dev)4412', now() - interval '3 days',65,2,1,3,4500,'1 week','low'),
('Autonomous QA Agent Pilot','feature','pending','vala(devops)3341', now() - interval '1 day',88,4,0,1,15400,'4 weeks','high');

INSERT INTO public.rnd_notifications (type, title, message, read, created_at) VALUES
('idea','New Idea Submitted','AI-Powered Code Review has been added to Future Lab', false, now() - interval '2 minutes'),
('trend','Trend Detected','New automation opportunity detected. Revenue impact: Medium.', false, now() - interval '15 minutes'),
('risk','Risk Alert','Prototype "Holographic Dashboard" performance load exceeds threshold', true, now() - interval '1 hour'),
('approval','Decision Required','One-Click Deployment Pipeline awaiting final approval', true, now() - interval '2 hours'),
('feedback','Pain Point Threshold','User pain point "deployment speed" exceeds alert threshold', true, now() - interval '3 hours');

INSERT INTO public.rnd_budgets (id, period, total_budget, currency, is_current) VALUES
('11111111-1111-4111-8111-111111111111','Q4 2026',75000,'USD',true);

INSERT INTO public.rnd_transactions (budget_id, description, amount, type, status, occurred_on) VALUES
('11111111-1111-4111-8111-111111111111','AI Code Review - Phase 1',-4500,'deduction','completed', current_date),
('11111111-1111-4111-8111-111111111111','Prototype Builder License',-2200,'deduction','pending', current_date - 1),
('11111111-1111-4111-8111-111111111111','Q4 Budget Allocation',50000,'credit','completed', current_date - 30),
('11111111-1111-4111-8111-111111111111','ROI Return - Deployment Pipeline',8500,'credit','completed', current_date - 33),
('11111111-1111-4111-8111-111111111111','Research Data Subscription',-1800,'deduction','completed', current_date - 12),
('11111111-1111-4111-8111-111111111111','Holographic Dashboard - Sprint 3',-13200,'deduction','completed', current_date - 6);

INSERT INTO public.rnd_technologies (name, category, ring, description, relevance) VALUES
('TypeScript 5.x','languages','adopt','Mature type safety for JS apps',95),
('React 19','frameworks','adopt','Server components, improved Suspense',92),
('Bun Runtime','tools','trial','Fast all-in-one JS runtime',78),
('Deno 2.0','platforms','trial','Secure Node alternative with npm support',75),
('HTMX','techniques','assess','Server-driven UI without heavy JS',65),
('Rust for WebAssembly','languages','trial','High-performance browser compute',72),
('Edge Computing','infrastructure','adopt','Distributed compute at CDN edge',88),
('AI Code Assistants','tools','adopt','GitHub Copilot, Cursor, etc.',90),
('GraphQL Federation','techniques','trial','Unified API from microservices',70),
('Web Components','frameworks','assess','Framework-agnostic components',55),
('Temporal Workflows','platforms','assess','Durable execution engine',60),
('Vector Databases','infrastructure','trial','AI embeddings storage',82),
('Client-Side ORMs','tools','hold','Heavy bundles with unclear caching wins',31),
('Monolithic CSS Frameworks','frameworks','hold','Conflicts with our token-driven design system',28);

INSERT INTO public.rnd_pipeline_items (title, description, stage, progress, priority, assignee, due_date, ai_score) VALUES
('AI-Powered Code Review','Automated code review with AI suggestions','prototype',65,'high','vala(rnd)2341', current_date + 21, 87),
('Real-Time Collaboration','Multi-cursor editing with presence','testing',85,'critical','vala(dev)4412', current_date + 14, 92),
('Visual Database Designer','Drag-and-drop schema builder','research',35,'medium','vala(design)8892', current_date + 45, 78),
('Smart Task Automation','AI-driven task distribution','ideation',15,'high','vala(rnd)2341', current_date + 60, 81),
('Predictive Analytics Dashboard','ML-powered business insights','launch',95,'high','vala(data)5567', current_date + 7, 89),
('Self-Healing Integration Monitor','Automated recovery for failing integrations','prototype',48,'high','vala(devops)3341', current_date + 30, 83),
('Unified Design Token Pipeline','Tokens synced across web, mobile and docs','completed',100,'medium','vala(design)8892', current_date - 5, 76);
