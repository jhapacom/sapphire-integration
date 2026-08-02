import { motion } from "framer-motion";
import {
  Lightbulb,
  Bot,
  Target,
  Radar,
  Rocket,
  Blocks,
  Gauge,
  TrendingUp,
  MessagesSquare,
  Map,
  Wallet,
  Bell,
} from "lucide-react";
import logo from "@/assets/software-vala-logo.png";
import { cn } from "@/lib/utils";

export const rndSections = [
  { id: "future-lab", label: "Future Lab", icon: Lightbulb },
  { id: "ai-assistant", label: "AI Assistant", icon: Bot },
  { id: "idea-scorer", label: "Idea Scorer", icon: Target },
  { id: "tech-radar", label: "Tech Radar", icon: Radar },
  { id: "pipeline", label: "Innovation Pipeline", icon: Rocket },
  { id: "prototype", label: "Prototype Builder", icon: Blocks },
  { id: "impact", label: "Impact Analyzer", icon: Gauge },
  { id: "trends", label: "Trend Scanner", icon: TrendingUp },
  { id: "feedback", label: "Feedback Portal", icon: MessagesSquare },
  { id: "decisions", label: "Decision Board", icon: Map },
  { id: "wallet", label: "R&D Budget", icon: Wallet },
  { id: "notifications", label: "Notifications", icon: Bell },
] as const;

export type RnDSectionId = (typeof rndSections)[number]["id"];

interface RnDSidebarProps {
  activeTab: string;
  onTabChange: (tab: RnDSectionId) => void;
  unreadCount: number;
}

export const RnDSidebar = ({ activeTab, onTabChange, unreadCount }: RnDSidebarProps) => {
  return (
    <aside className="hidden w-64 shrink-0 flex-col border-r border-border bg-sidebar/80 backdrop-blur-xl lg:flex">
      <div className="flex items-center gap-3 border-b border-border px-6 py-5">
        <img src={logo} alt="Software Vala logo" width={40} height={40} className="h-10 w-10 object-contain" />
        <div>
          <p className="font-display text-sm font-semibold text-foreground">Software Vala</p>
          <p className="text-xs text-brand">R&amp;D Department</p>
        </div>
      </div>

      <nav className="scroll-slim flex-1 space-y-1 overflow-y-auto p-4">
        {rndSections.map((item, index) => {
          const Icon = item.icon;
          const isActive = activeTab === item.id;
          return (
            <motion.button
              key={item.id}
              type="button"
              onClick={() => onTabChange(item.id)}
              initial={{ opacity: 0, x: -16 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: index * 0.03 }}
              whileHover={{ x: 4 }}
              className={cn(
                "flex w-full items-center gap-3 rounded-xl px-4 py-2.5 text-sm transition-colors",
                isActive
                  ? "brand-soft border border-border text-foreground shadow-glow"
                  : "text-muted-foreground hover:bg-surface-2 hover:text-foreground",
              )}
            >
              <Icon className={cn("h-4 w-4", isActive && "text-brand")} />
              <span className="flex-1 text-left">{item.label}</span>
              {item.id === "notifications" && unreadCount > 0 && (
                <span className="rounded-full bg-brand/20 px-2 py-0.5 text-xs text-brand">{unreadCount}</span>
              )}
              {isActive && (
                <motion.span
                  className="h-1.5 w-1.5 rounded-full bg-brand"
                  animate={{ scale: [1, 1.3, 1] }}
                  transition={{ duration: 1.5, repeat: Infinity }}
                />
              )}
            </motion.button>
          );
        })}
      </nav>

      <div className="border-t border-border p-4">
        <div className="panel flex items-center gap-3 px-4 py-3">
          <span className="flex h-8 w-8 items-center justify-center rounded-full bg-brand/20 text-xs font-bold text-brand">
            RD
          </span>
          <div>
            <p className="text-sm text-foreground">R&amp;D Workspace</p>
            <p className="text-xs text-muted-foreground">Live data</p>
          </div>
        </div>
      </div>
    </aside>
  );
};
