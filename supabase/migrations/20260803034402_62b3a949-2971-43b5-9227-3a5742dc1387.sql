
-- PRO MANAGER MODULE
CREATE TABLE public.pm_users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  product text NOT NULL,
  license text NOT NULL DEFAULT 'Annual',
  region text NOT NULL DEFAULT 'Global',
  tier text NOT NULL DEFAULT 'Standard',
  status text NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_users TO anon, authenticated;
GRANT ALL ON public.pm_users TO service_role;
ALTER TABLE public.pm_users ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_users_public_read ON public.pm_users FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code text NOT NULL,
  product text NOT NULL,
  version text NOT NULL DEFAULT 'v1.0.0',
  modules text[] NOT NULL DEFAULT '{}',
  custom_changes text NOT NULL DEFAULT 'None',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_products TO anon, authenticated;
GRANT ALL ON public.pm_products TO service_role;
ALTER TABLE public.pm_products ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_products_public_read ON public.pm_products FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_licenses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code text NOT NULL,
  license_type text NOT NULL DEFAULT 'Annual',
  domain text NOT NULL DEFAULT '',
  domain_status text NOT NULL DEFAULT 'bound',
  expiry text NOT NULL DEFAULT 'Never',
  transfer_status text NOT NULL DEFAULT 'Not Requested',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_licenses TO anon, authenticated;
GRANT ALL ON public.pm_licenses TO service_role;
ALTER TABLE public.pm_licenses ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_licenses_public_read ON public.pm_licenses FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_tickets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  user_code text NOT NULL DEFAULT '',
  type text NOT NULL DEFAULT 'Technical',
  severity text NOT NULL DEFAULT 'Medium',
  product text NOT NULL DEFAULT '',
  subject text NOT NULL DEFAULT '',
  status text NOT NULL DEFAULT 'new',
  opened_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_tickets TO anon, authenticated;
GRANT ALL ON public.pm_tickets TO service_role;
ALTER TABLE public.pm_tickets ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_tickets_public_read ON public.pm_tickets FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_issues (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  build text NOT NULL DEFAULT '',
  summary text NOT NULL DEFAULT '',
  status text NOT NULL DEFAULT 'open',
  ai_attempts integer NOT NULL DEFAULT 0,
  last_attempt_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_issues TO anon, authenticated;
GRANT ALL ON public.pm_issues TO service_role;
ALTER TABLE public.pm_issues ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_issues_public_read ON public.pm_issues FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_assist_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  user_code text NOT NULL,
  mode text NOT NULL DEFAULT 'View Only',
  duration_minutes integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_assist_sessions TO anon, authenticated;
GRANT ALL ON public.pm_assist_sessions TO service_role;
ALTER TABLE public.pm_assist_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_assist_public_read ON public.pm_assist_sessions FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_promises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  action text NOT NULL,
  task_code text NOT NULL DEFAULT '',
  developer_code text NOT NULL DEFAULT '',
  owner text NOT NULL DEFAULT 'Support',
  type text NOT NULL DEFAULT 'Feature Delivery',
  deadline timestamptz NOT NULL DEFAULT now(),
  priority text NOT NULL DEFAULT 'medium',
  status text NOT NULL DEFAULT 'on_track',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_promises TO anon, authenticated;
GRANT ALL ON public.pm_promises TO service_role;
ALTER TABLE public.pm_promises ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_promises_public_read ON public.pm_promises FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_upgrades (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  user_code text NOT NULL,
  type text NOT NULL DEFAULT 'Feature Add-on',
  item text NOT NULL DEFAULT '',
  status text NOT NULL DEFAULT 'pending',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_upgrades TO anon, authenticated;
GRANT ALL ON public.pm_upgrades TO service_role;
ALTER TABLE public.pm_upgrades ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_upgrades_public_read ON public.pm_upgrades FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_renewals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  user_code text NOT NULL,
  product text NOT NULL DEFAULT '',
  expiry date NOT NULL DEFAULT CURRENT_DATE,
  grace text NOT NULL DEFAULT '7 days',
  status text NOT NULL DEFAULT 'upcoming',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_renewals TO anon, authenticated;
GRANT ALL ON public.pm_renewals TO service_role;
ALTER TABLE public.pm_renewals ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_renewals_public_read ON public.pm_renewals FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_usage (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code text NOT NULL,
  api_pct integer NOT NULL DEFAULT 0,
  storage_pct integer NOT NULL DEFAULT 0,
  ai_calls_pct integer NOT NULL DEFAULT 0,
  fair_usage_alert boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_usage TO anon, authenticated;
GRANT ALL ON public.pm_usage TO service_role;
ALTER TABLE public.pm_usage ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_usage_public_read ON public.pm_usage FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_ai_conversations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  user_code text NOT NULL,
  topic text NOT NULL DEFAULT '',
  language text NOT NULL DEFAULT 'English',
  status text NOT NULL DEFAULT 'active',
  resolution text NOT NULL DEFAULT 'In Progress',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_ai_conversations TO anon, authenticated;
GRANT ALL ON public.pm_ai_conversations TO service_role;
ALTER TABLE public.pm_ai_conversations ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_ai_conv_public_read ON public.pm_ai_conversations FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_ai_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id uuid NOT NULL REFERENCES public.pm_ai_conversations(id) ON DELETE CASCADE,
  role text NOT NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_ai_messages TO anon, authenticated;
GRANT ALL ON public.pm_ai_messages TO service_role;
ALTER TABLE public.pm_ai_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_ai_msg_public_read ON public.pm_ai_messages FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_communication_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  type text NOT NULL DEFAULT 'chat',
  user_code text NOT NULL DEFAULT '',
  content text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_communication_logs TO anon, authenticated;
GRANT ALL ON public.pm_communication_logs TO service_role;
ALTER TABLE public.pm_communication_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_comm_public_read ON public.pm_communication_logs FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_alerts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  type text NOT NULL DEFAULT 'sla',
  message text NOT NULL DEFAULT '',
  severity text NOT NULL DEFAULT 'medium',
  acknowledged boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_alerts TO anon, authenticated;
GRANT ALL ON public.pm_alerts TO service_role;
ALTER TABLE public.pm_alerts ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_alerts_public_read ON public.pm_alerts FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_satisfaction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code text NOT NULL,
  csat integer NOT NULL DEFAULT 0,
  feedback text NOT NULL DEFAULT '',
  risk text NOT NULL DEFAULT 'low',
  ai_prediction text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_satisfaction TO anon, authenticated;
GRANT ALL ON public.pm_satisfaction TO service_role;
ALTER TABLE public.pm_satisfaction ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_satisfaction_public_read ON public.pm_satisfaction FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_compliance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code text NOT NULL,
  agreement_accepted boolean NOT NULL DEFAULT true,
  violations integer NOT NULL DEFAULT 0,
  legal_flag boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_compliance TO anon, authenticated;
GRANT ALL ON public.pm_compliance TO service_role;
ALTER TABLE public.pm_compliance ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_compliance_public_read ON public.pm_compliance FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  action text NOT NULL,
  category text NOT NULL DEFAULT 'system',
  details text NOT NULL DEFAULT '',
  actor text NOT NULL DEFAULT 'System',
  target text NOT NULL DEFAULT '',
  ip text NOT NULL DEFAULT 'Internal',
  status text NOT NULL DEFAULT 'completed',
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_audit_logs TO anon, authenticated;
GRANT ALL ON public.pm_audit_logs TO service_role;
ALTER TABLE public.pm_audit_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_audit_public_read ON public.pm_audit_logs FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  key text NOT NULL UNIQUE,
  label text NOT NULL,
  section text NOT NULL DEFAULT 'notifications',
  enabled boolean NOT NULL DEFAULT true,
  locked boolean NOT NULL DEFAULT false,
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_settings TO anon, authenticated;
GRANT ALL ON public.pm_settings TO service_role;
ALTER TABLE public.pm_settings ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_settings_public_read ON public.pm_settings FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_health_metrics (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  status text NOT NULL DEFAULT 'healthy',
  value text NOT NULL DEFAULT '',
  trend text NOT NULL DEFAULT 'stable',
  description text NOT NULL DEFAULT '',
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_health_metrics TO anon, authenticated;
GRANT ALL ON public.pm_health_metrics TO service_role;
ALTER TABLE public.pm_health_metrics ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_health_public_read ON public.pm_health_metrics FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_escalations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  source text NOT NULL DEFAULT 'task_manager',
  source_id text NOT NULL DEFAULT '',
  subject text NOT NULL,
  description text NOT NULL DEFAULT '',
  priority text NOT NULL DEFAULT 'medium',
  status text NOT NULL DEFAULT 'pending',
  evidence text[] NOT NULL DEFAULT '{}',
  decision_note text NOT NULL DEFAULT '',
  created_by text NOT NULL DEFAULT 'SYSTEM',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_escalations TO anon, authenticated;
GRANT ALL ON public.pm_escalations TO service_role;
ALTER TABLE public.pm_escalations ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_escalations_public_read ON public.pm_escalations FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_quality_alerts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  pattern text NOT NULL,
  description text NOT NULL DEFAULT '',
  affected_entity text NOT NULL DEFAULT '',
  entity_type text NOT NULL DEFAULT 'team',
  severity text NOT NULL DEFAULT 'medium',
  suggested_action text NOT NULL DEFAULT '',
  confidence integer NOT NULL DEFAULT 0,
  reasoning text NOT NULL DEFAULT '',
  acknowledged boolean NOT NULL DEFAULT false,
  detected_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_quality_alerts TO anon, authenticated;
GRANT ALL ON public.pm_quality_alerts TO service_role;
ALTER TABLE public.pm_quality_alerts ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_quality_public_read ON public.pm_quality_alerts FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_manager_metrics (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  manager_code text NOT NULL UNIQUE,
  role text NOT NULL DEFAULT 'task_manager',
  sla_compliance integer NOT NULL DEFAULT 0,
  escalations_handled integer NOT NULL DEFAULT 0,
  escalations_pending integer NOT NULL DEFAULT 0,
  avg_resolution_time text NOT NULL DEFAULT '0h',
  trend text NOT NULL DEFAULT 'stable',
  status text NOT NULL DEFAULT 'healthy',
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_manager_metrics TO anon, authenticated;
GRANT ALL ON public.pm_manager_metrics TO service_role;
ALTER TABLE public.pm_manager_metrics ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_manager_public_read ON public.pm_manager_metrics FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_decisions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  type text NOT NULL DEFAULT 'exception',
  subject text NOT NULL,
  description text NOT NULL DEFAULT '',
  requested_by text NOT NULL DEFAULT '',
  priority text NOT NULL DEFAULT 'medium',
  is_financial boolean NOT NULL DEFAULT false,
  amount integer,
  status text NOT NULL DEFAULT 'pending',
  decision_note text NOT NULL DEFAULT '',
  requested_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_decisions TO anon, authenticated;
GRANT ALL ON public.pm_decisions TO service_role;
ALTER TABLE public.pm_decisions ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_decisions_public_read ON public.pm_decisions FOR SELECT TO anon, authenticated USING (true);

CREATE TABLE public.pm_reports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  type text NOT NULL DEFAULT 'daily',
  size text NOT NULL DEFAULT '0 MB',
  generated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.pm_reports TO anon, authenticated;
GRANT ALL ON public.pm_reports TO service_role;
ALTER TABLE public.pm_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY pm_reports_public_read ON public.pm_reports FOR SELECT TO anon, authenticated USING (true);

CREATE OR REPLACE FUNCTION public.pm_touch_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = public
AS $$ BEGIN NEW.updated_at = now(); RETURN NEW; END; $$;

CREATE TRIGGER pm_users_touch BEFORE UPDATE ON public.pm_users FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_tickets_touch BEFORE UPDATE ON public.pm_tickets FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_issues_touch BEFORE UPDATE ON public.pm_issues FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_promises_touch BEFORE UPDATE ON public.pm_promises FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_upgrades_touch BEFORE UPDATE ON public.pm_upgrades FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_renewals_touch BEFORE UPDATE ON public.pm_renewals FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_escalations_touch BEFORE UPDATE ON public.pm_escalations FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_decisions_touch BEFORE UPDATE ON public.pm_decisions FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_assist_touch BEFORE UPDATE ON public.pm_assist_sessions FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();
CREATE TRIGGER pm_quality_touch BEFORE UPDATE ON public.pm_quality_alerts FOR EACH ROW EXECUTE FUNCTION public.pm_touch_updated_at();

-- SEED DATA
INSERT INTO public.pm_users (code, product, license, region, tier, status) VALUES
('PRO-4421','Enterprise Suite','Lifetime','North America','Premium','active'),
('PRO-4445','Business Pro','Annual','Europe','Standard','active'),
('PRO-4478','Agency Pack','Annual','Asia Pacific','Premium','suspended'),
('PRO-4492','Developer Kit','Lifetime','Middle East','Basic','expired'),
('PRO-4433','Enterprise Suite','Annual','Europe','Premium','high_risk'),
('PRO-4510','Business Pro','Annual','South America','Standard','active'),
('PRO-4526','Agency Pack','Lifetime','Africa','Premium','active');

INSERT INTO public.pm_products (user_code, product, version, modules, custom_changes) VALUES
('PRO-4421','Enterprise Suite','v4.2.1','{CRM,Analytics,API,White-label}','Custom branding applied'),
('PRO-4445','Business Pro','v3.8.0','{CRM,Analytics}','None'),
('PRO-4478','Agency Pack','v4.0.0','{CRM,Analytics,Multi-tenant}','Extended API limits'),
('PRO-4492','Developer Kit','v2.6.4','{API,Sandbox}','None'),
('PRO-4433','Enterprise Suite','v4.2.0','{CRM,Analytics,API}','Regional data residency');

INSERT INTO public.pm_licenses (user_code, license_type, domain, domain_status, expiry, transfer_status) VALUES
('PRO-4421','Lifetime','enterprise.example.com','bound','Never','Not Requested'),
('PRO-4445','Annual','business-pro.example.io','bound','2026-06-15','Pending Approval'),
('PRO-4478','Annual','agency-pack.example.net','unbound','2026-03-20','Not Requested'),
('PRO-4492','Lifetime','devkit.example.dev','bound','Never','Completed'),
('PRO-4433','Annual','vala-eu.example.eu','bound','2026-09-01','Not Requested');

INSERT INTO public.pm_tickets (code, user_code, type, severity, product, subject, status, opened_at) VALUES
('TKT-1001','PRO-4421','Technical','High','Enterprise Suite','API rate limit errors on bulk sync','new', now() - interval '2 hours'),
('TKT-1002','PRO-4445','Billing','Medium','Business Pro','Invoice mismatch for January','in_progress', now() - interval '1 day'),
('TKT-1003','PRO-4478','Feature','Low','Agency Pack','Request for white-label email templates','waiting_user', now() - interval '3 days'),
('TKT-1004','PRO-4492','Bug','Critical','Developer Kit','SDK crash on token refresh','escalated', now() - interval '5 hours'),
('TKT-1005','PRO-4421','Technical','Medium','Enterprise Suite','SSO metadata refresh failing','resolved', now() - interval '2 days'),
('TKT-1006','PRO-4433','Technical','High','Enterprise Suite','Data residency export delayed','in_progress', now() - interval '9 hours');

INSERT INTO public.pm_issues (code, build, summary, status, ai_attempts, last_attempt_at) VALUES
('BUG-2001','v4.2.1-beta','Webhook retries duplicate events','open',2, now() - interval '1 hour'),
('BUG-2002','v4.2.0','Analytics widget renders stale cache','ai_fixing',1, now() - interval '30 minutes'),
('BUG-2003','v4.1.9','Role editor drops nested permissions','dev_review',3, now() - interval '2 hours'),
('BUG-2004','v4.2.1-beta','CSV export truncates unicode names','resolved',1, now() - interval '1 day'),
('BUG-2005','v4.2.1-beta','Domain binding fails on subdomain','open',0, NULL);

INSERT INTO public.pm_assist_sessions (code, user_code, mode, duration_minutes, status) VALUES
('ASSIST-3001','PRO-4421','View Only',15,'active'),
('ASSIST-3002','PRO-4445','Guided',8,'paused'),
('ASSIST-3003','PRO-4478','Full Control',45,'ended'),
('ASSIST-3004','PRO-4433','Guided',22,'active'),
('ASSIST-3005','PRO-4510','View Only',5,'active');

INSERT INTO public.pm_promises (code, action, task_code, developer_code, owner, type, deadline, priority, status) VALUES
('PRM-0891','Feature delivery: bulk sync throttling','TSK-4521','DEV-7823','Dev Team','Feature Delivery', now() + interval '2 hours','critical','near_breach'),
('PRM-0892','Bug fix delivery: SDK token refresh','TSK-4522','DEV-7824','Dev Team','Bug Fix', now() - interval '4 hours','high','breached'),
('PRM-0893','Code review for analytics module','TSK-4523','DEV-7825','Product','Code Review', now() + interval '18 hours','medium','on_track'),
('PRM-0894','Integration handover for Agency Pack','TSK-4524','DEV-7826','Support','Integration', now() + interval '4 hours','high','near_breach'),
('PRM-0895','Security patch rollout','TSK-4525','DEV-7827','Dev Team','Security Patch', now() - interval '8 hours','critical','breached'),
('PRM-0896','Account migration for EU tenant','TSK-4526','DEV-7828','Support','Migration', now() + interval '3 days','medium','on_track'),
('PRM-0897','License upgrade provisioning','TSK-4527','DEV-7829','Billing','Provisioning', now() + interval '5 days','low','fulfilled');

INSERT INTO public.pm_upgrades (code, user_code, type, item, status) VALUES
('UPG-5001','PRO-4421','Feature Add-on','Advanced Analytics','pending'),
('UPG-5002','PRO-4445','Capacity','+50GB Storage','pending'),
('UPG-5003','PRO-4478','AI Credits','10,000 Credits','approved'),
('UPG-5004','PRO-4492','Support Tier','Premium to Enterprise','pending'),
('UPG-5005','PRO-4510','Feature Add-on','Multi-tenant Console','pending');

INSERT INTO public.pm_renewals (code, user_code, product, expiry, grace, status) VALUES
('RNW-6001','PRO-4421','Enterprise Suite', CURRENT_DATE + 21,'7 days','upcoming'),
('RNW-6002','PRO-4445','Business Pro', CURRENT_DATE + 3,'3 days','due'),
('RNW-6003','PRO-4478','Agency Pack', CURRENT_DATE - 4,'Expired','grace'),
('RNW-6004','PRO-4492','Developer Kit', CURRENT_DATE - 20,'Expired','suspended'),
('RNW-6005','PRO-4433','Enterprise Suite', CURRENT_DATE + 45,'7 days','upcoming');

INSERT INTO public.pm_usage (user_code, api_pct, storage_pct, ai_calls_pct, fair_usage_alert) VALUES
('PRO-4421',85,72,45,true),
('PRO-4445',45,30,20,false),
('PRO-4478',92,88,78,true),
('PRO-4492',15,10,5,false),
('PRO-4433',68,54,61,false);

INSERT INTO public.pm_ai_conversations (code, user_code, topic, language, status, resolution) VALUES
('AI-7001','PRO-4421','API Integration','English','active','In Progress'),
('AI-7002','PRO-4445','Billing Query','Spanish','active','Suggested'),
('AI-7003','PRO-4478','Feature Request','German','resolved','Auto-Resolved'),
('AI-7004','PRO-4492','Bug Report','French','escalated','Ticket Created');

INSERT INTO public.pm_communication_logs (code, type, user_code, content, created_at) VALUES
('LOG-8001','chat','PRO-4421','User inquired about API rate limits on bulk sync endpoints.', now() - interval '10 minutes'),
('LOG-8002','ai','PRO-4445','AI suggested reconciling the January invoice against usage exports.', now() - interval '25 minutes'),
('LOG-8003','assist','PRO-4478','Assist session note: configured multi-tenant integration mapping.', now() - interval '1 hour'),
('LOG-8004','chat','PRO-4492','Support escalation initiated for SDK crash on token refresh.', now() - interval '2 hours'),
('LOG-8005','ai','PRO-4421','Auto-resolved: SSO metadata refresh guidance delivered.', now() - interval '3 hours');

INSERT INTO public.pm_alerts (code, type, message, severity, created_at) VALUES
('ALT-9001','sla','SLA breach for PRO-4421 — response time exceeded','high', now() - interval '5 minutes'),
('ALT-9002','payment','Payment failed for PRO-4445 — card declined','medium', now() - interval '1 hour'),
('ALT-9003','security','Suspicious login attempt for PRO-4478','critical', now() - interval '2 hours'),
('ALT-9004','sla','Promise deadline approaching for PRO-4492','low', now() - interval '3 hours'),
('ALT-9005','payment','Renewal payment on hold for PRO-4433','medium', now() - interval '6 hours'),
('ALT-9006','sla','Escalated ticket TKT-1004 nearing SLA limit','high', now() - interval '8 hours');

INSERT INTO public.pm_satisfaction (user_code, csat, feedback, risk, ai_prediction) VALUES
('PRO-4421',92,'Excellent support, quick resolution','low','Retention likely; upsell candidate for analytics add-on.'),
('PRO-4445',78,'Good but could be faster','medium','Monitor response times; billing friction is the main driver.'),
('PRO-4478',45,'Delayed response, issue unresolved','high','Churn risk within 60 days without an assist session.'),
('PRO-4492',88,'Very helpful, great experience','low','Stable; renewal expected without intervention.'),
('PRO-4433',71,'Data residency export took too long','medium','Watch EU compliance turnaround times.');

INSERT INTO public.pm_compliance (user_code, agreement_accepted, violations, legal_flag) VALUES
('PRO-4421',true,0,false),
('PRO-4445',true,1,false),
('PRO-4478',false,2,true),
('PRO-4492',true,0,false),
('PRO-4433',true,0,false);

INSERT INTO public.pm_audit_logs (action, category, details, actor, target, ip, status, created_at) VALUES
('License Renewed','system','Annual license renewed automatically','System','PRO-4421','192.168.***','completed', now() - interval '30 minutes'),
('Support Ticket Created','system','Ticket opened by premium user','User','TKT-1001','10.0.***','completed', now() - interval '2 hours'),
('AI Auto-Resolution','ai_review','AI resolved billing query without human handoff','AI','TKT-1002','Internal','completed', now() - interval '3 hours'),
('Access Suspended','decision','Access suspended pending compliance review','Admin','PRO-4478','172.16.***','completed', now() - interval '5 hours'),
('Security Alert Triggered','system','Suspicious login detected and blocked','System','PRO-4492','Internal','completed', now() - interval '7 hours'),
('Escalation Resolved','escalation','ESC-001 resolved with corrective action plan','Pro Manager','ESC-001','Internal','completed', now() - interval '9 hours'),
('Financial Recommendation','decision','DEC-003 penalty waiver recommended to Finance','Pro Manager','DEC-003','Internal','forwarded', now() - interval '1 day');

INSERT INTO public.pm_settings (key, label, section, enabled, locked) VALUES
('sla_alerts','SLA Breach Alerts','notifications',true,false),
('payment_alerts','Payment Alerts','notifications',true,false),
('security_alerts','Security Alerts','notifications',true,false),
('ai_first_response','AI First Response','ai',true,false),
('ai_auto_resolution','AI Auto-Resolution','ai',true,false),
('log_all_sessions','Log All Sessions','security',true,true),
('mask_sensitive_data','Mask Sensitive Data','security',true,true);

INSERT INTO public.pm_health_metrics (code, name, status, value, trend, description) VALUES
('HM-001','Promise Fulfillment Rate','healthy','94.2%','up','Overall promise completion across all teams'),
('HM-002','SLA Compliance','warning','87.5%','down','Tasks completed within SLA window'),
('HM-003','Escalation Resolution','healthy','91.8%','stable','Escalations resolved within target time'),
('HM-004','Quality Score','healthy','4.6/5.0','up','Average quality rating across deliverables'),
('HM-005','Active Issues','warning','12','up','Unresolved quality issues pending review'),
('HM-006','Team Utilization','healthy','78%','stable','Average developer workload capacity');

INSERT INTO public.pm_escalations (code, source, source_id, subject, description, priority, status, evidence, created_by, created_at) VALUES
('ESC-001','task_manager','TM-7823','Repeated SLA breaches — DEV-4521','Developer has breached SLA 3 times in the past week. Pattern indicates a potential capacity issue.','critical','pending','{SLA-Report-0891.pdf,Timeline-Analysis.xlsx}','TM-SYSTEM', now() - interval '6 hours'),
('ESC-002','dev_manager','DM-3421','Quality decline — Project Alpha','Code review rejection rate increased to 45% over the past 2 weeks. Requires quality intervention.','high','in_review','{Quality-Metrics.pdf,Review-History.json}','DM-7821', now() - interval '1 day'),
('ESC-003','legal','LM-1234','Policy violation report','Partner account flagged for potential trademark misuse. Requires quality review before action.','medium','pending','{Trademark-Report.pdf,Screenshots.zip}','LM-5432', now() - interval '2 days');

INSERT INTO public.pm_quality_alerts (code, pattern, description, affected_entity, entity_type, severity, suggested_action, confidence, reasoning, acknowledged, detected_at) VALUES
('QA-001','SLA Risk Pattern','Increasing SLA breach frequency detected across Team Alpha','TEAM-ALPHA','team','high','Review workload distribution and consider temporary resource reallocation',87,'Based on 14-day trend analysis: 3 breaches in week 1 vs 7 breaches in week 2. Correlation with new project assignments.',false, now() - interval '4 hours'),
('QA-002','Underperformance Pattern','Developer showing 40% decline in completion rate over 30 days','DEV-7823','developer','medium','Schedule a 1:1 review to identify blockers. Do not apply penalty without investigation.',92,'Completion rate dropped from 95% to 57%. No corresponding increase in task complexity. May indicate blockers or burnout.',false, now() - interval '1 day'),
('QA-003','Code Quality Decline','Project Beta showing increased code review rejection rate','PRJ-BETA','project','medium','Review code standards documentation. Consider mandatory pair programming for critical modules.',78,'Rejection rate increased from 12% to 34% over 3 weeks. Pattern concentrated in backend modules.',true, now() - interval '2 days'),
('QA-004','Promise Overcommitment','Multiple developers accepting promises beyond capacity','TEAM-GAMMA','team','low','Implement stricter promise acceptance controls. Recommend a capacity visibility dashboard.',71,'Average active promises per developer increased from 3 to 5.5. No corresponding productivity increase.',true, now() - interval '3 days');

INSERT INTO public.pm_manager_metrics (manager_code, role, sla_compliance, escalations_handled, escalations_pending, avg_resolution_time, trend, status) VALUES
('TM-7823','task_manager',94,23,2,'2.4h','up','healthy'),
('DM-3421','dev_manager',87,18,5,'3.8h','down','warning'),
('LM-5432','lead_manager',91,12,1,'1.9h','stable','healthy'),
('TM-8912','task_manager',78,15,8,'5.2h','down','critical');

INSERT INTO public.pm_decisions (code, type, subject, description, requested_by, priority, is_financial, amount, status, requested_at) VALUES
('DEC-001','exception','SLA exception request — Project Delta','Request to waive SLA penalty due to external dependency delay (third-party API outage)','DM-3421','high',false,NULL,'pending', now() - interval '5 hours'),
('DEC-002','extension','Deadline extension — Feature XYZ','Request 48h extension for feature delivery due to scope expansion mid-sprint','TM-7823','medium',false,NULL,'pending', now() - interval '1 day'),
('DEC-003','financial','Penalty waiver request','Request to waive a 15,000 penalty for DEV-4521 due to a documented personal emergency','DM-3421','high',true,15000,'pending', now() - interval '2 days'),
('DEC-004','override','Priority override — bug fix','Request to override task priority from medium to critical for a security-related bug','LM-5432','critical',false,NULL,'pending', now() - interval '6 hours');

INSERT INTO public.pm_reports (code, name, type, size, generated_at) VALUES
('RPT-001','Daily Quality Summary','daily','2.4 MB', now() - interval '6 hours'),
('RPT-002','Weekly SLA Report','weekly','8.7 MB', now() - interval '2 days'),
('RPT-003','Monthly Performance Review','monthly','24.3 MB', now() - interval '14 days'),
('RPT-004','Escalation Trends Analysis','custom','5.1 MB', now() - interval '5 days');
