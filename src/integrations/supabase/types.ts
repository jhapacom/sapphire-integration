export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.15"
  }
  public: {
    Tables: {
      rnd_ai_messages: {
        Row: {
          content: string
          created_at: string
          id: string
          role: string
          session_id: string
        }
        Insert: {
          content: string
          created_at?: string
          id?: string
          role: string
          session_id: string
        }
        Update: {
          content?: string
          created_at?: string
          id?: string
          role?: string
          session_id?: string
        }
        Relationships: []
      }
      rnd_budgets: {
        Row: {
          created_at: string
          currency: string
          id: string
          is_current: boolean
          period: string
          total_budget: number
        }
        Insert: {
          created_at?: string
          currency?: string
          id?: string
          is_current?: boolean
          period: string
          total_budget?: number
        }
        Update: {
          created_at?: string
          currency?: string
          id?: string
          is_current?: boolean
          period?: string
          total_budget?: number
        }
        Relationships: []
      }
      rnd_decisions: {
        Row: {
          ai_score: number
          estimated_cost: number
          estimated_time: string
          id: string
          priority: string
          status: string
          submitted_at: string
          submitted_by: string
          title: string
          type: string
          votes_approve: number
          votes_hold: number
          votes_reject: number
        }
        Insert: {
          ai_score?: number
          estimated_cost?: number
          estimated_time?: string
          id?: string
          priority?: string
          status?: string
          submitted_at?: string
          submitted_by?: string
          title: string
          type?: string
          votes_approve?: number
          votes_hold?: number
          votes_reject?: number
        }
        Update: {
          ai_score?: number
          estimated_cost?: number
          estimated_time?: string
          id?: string
          priority?: string
          status?: string
          submitted_at?: string
          submitted_by?: string
          title?: string
          type?: string
          votes_approve?: number
          votes_hold?: number
          votes_reject?: number
        }
        Relationships: []
      }
      rnd_feedback: {
        Row: {
          category: string
          content: string
          created_at: string
          id: string
          sentiment: string
          sentiment_score: number
          source: string
          status: string
          votes: number
        }
        Insert: {
          category?: string
          content: string
          created_at?: string
          id?: string
          sentiment?: string
          sentiment_score?: number
          source?: string
          status?: string
          votes?: number
        }
        Update: {
          category?: string
          content?: string
          created_at?: string
          id?: string
          sentiment?: string
          sentiment_score?: number
          source?: string
          status?: string
          votes?: number
        }
        Relationships: []
      }
      rnd_idea_evaluations: {
        Row: {
          ai_analysis: string
          category: string
          created_at: string
          description: string
          id: string
          scores: Json
          title: string
        }
        Insert: {
          ai_analysis?: string
          category?: string
          created_at?: string
          description?: string
          id?: string
          scores?: Json
          title: string
        }
        Update: {
          ai_analysis?: string
          category?: string
          created_at?: string
          description?: string
          id?: string
          scores?: Json
          title?: string
        }
        Relationships: []
      }
      rnd_ideas: {
        Row: {
          author: string
          category: string
          created_at: string
          description: string
          feasibility: number
          id: string
          priority: string
          research_links: number
          status: string
          title: string
          updated_at: string
          votes: number
        }
        Insert: {
          author?: string
          category?: string
          created_at?: string
          description?: string
          feasibility?: number
          id?: string
          priority?: string
          research_links?: number
          status?: string
          title: string
          updated_at?: string
          votes?: number
        }
        Update: {
          author?: string
          category?: string
          created_at?: string
          description?: string
          feasibility?: number
          id?: string
          priority?: string
          research_links?: number
          status?: string
          title?: string
          updated_at?: string
          votes?: number
        }
        Relationships: []
      }
      rnd_impact_analyses: {
        Row: {
          ai_recommendation: string
          created_at: string
          effort_level: string
          feature: string
          id: string
          maintenance_cost: string
          performance_load: number
          revenue_impact: string
          score_demand: number
          score_effort: number
          score_revenue: number
          score_risk: number
          technical_risk: string
          user_demand: number
        }
        Insert: {
          ai_recommendation?: string
          created_at?: string
          effort_level?: string
          feature: string
          id?: string
          maintenance_cost?: string
          performance_load?: number
          revenue_impact?: string
          score_demand?: number
          score_effort?: number
          score_revenue?: number
          score_risk?: number
          technical_risk?: string
          user_demand?: number
        }
        Update: {
          ai_recommendation?: string
          created_at?: string
          effort_level?: string
          feature?: string
          id?: string
          maintenance_cost?: string
          performance_load?: number
          revenue_impact?: string
          score_demand?: number
          score_effort?: number
          score_revenue?: number
          score_risk?: number
          technical_risk?: string
          user_demand?: number
        }
        Relationships: []
      }
      rnd_market_gaps: {
        Row: {
          created_at: string
          difficulty: string
          gap: string
          id: string
          potential: string
        }
        Insert: {
          created_at?: string
          difficulty?: string
          gap: string
          id?: string
          potential?: string
        }
        Update: {
          created_at?: string
          difficulty?: string
          gap?: string
          id?: string
          potential?: string
        }
        Relationships: []
      }
      rnd_notifications: {
        Row: {
          created_at: string
          dismissed: boolean
          id: string
          message: string
          read: boolean
          title: string
          type: string
        }
        Insert: {
          created_at?: string
          dismissed?: boolean
          id?: string
          message?: string
          read?: boolean
          title: string
          type?: string
        }
        Update: {
          created_at?: string
          dismissed?: boolean
          id?: string
          message?: string
          read?: boolean
          title?: string
          type?: string
        }
        Relationships: []
      }
      rnd_pipeline_items: {
        Row: {
          ai_score: number | null
          assignee: string
          created_at: string
          description: string
          due_date: string | null
          id: string
          priority: string
          progress: number
          stage: string
          title: string
          updated_at: string
        }
        Insert: {
          ai_score?: number | null
          assignee?: string
          created_at?: string
          description?: string
          due_date?: string | null
          id?: string
          priority?: string
          progress?: number
          stage?: string
          title: string
          updated_at?: string
        }
        Update: {
          ai_score?: number | null
          assignee?: string
          created_at?: string
          description?: string
          due_date?: string | null
          id?: string
          priority?: string
          progress?: number
          stage?: string
          title?: string
          updated_at?: string
        }
        Relationships: []
      }
      rnd_prototypes: {
        Row: {
          completed_hours: number
          created_at: string
          estimated_hours: number
          id: string
          integrations: string[]
          modules: string[]
          name: string
          progress: number
          status: string
          team: string[]
          updated_at: string
        }
        Insert: {
          completed_hours?: number
          created_at?: string
          estimated_hours?: number
          id?: string
          integrations?: string[]
          modules?: string[]
          name: string
          progress?: number
          status?: string
          team?: string[]
          updated_at?: string
        }
        Update: {
          completed_hours?: number
          created_at?: string
          estimated_hours?: number
          id?: string
          integrations?: string[]
          modules?: string[]
          name?: string
          progress?: number
          status?: string
          team?: string[]
          updated_at?: string
        }
        Relationships: []
      }
      rnd_technologies: {
        Row: {
          category: string
          created_at: string
          description: string
          id: string
          name: string
          relevance: number
          ring: string
        }
        Insert: {
          category?: string
          created_at?: string
          description?: string
          id?: string
          name: string
          relevance?: number
          ring?: string
        }
        Update: {
          category?: string
          created_at?: string
          description?: string
          id?: string
          name?: string
          relevance?: number
          ring?: string
        }
        Relationships: []
      }
      rnd_transactions: {
        Row: {
          amount: number
          budget_id: string
          created_at: string
          description: string
          id: string
          occurred_on: string
          status: string
          type: string
        }
        Insert: {
          amount: number
          budget_id: string
          created_at?: string
          description: string
          id?: string
          occurred_on?: string
          status?: string
          type?: string
        }
        Update: {
          amount?: number
          budget_id?: string
          created_at?: string
          description?: string
          id?: string
          occurred_on?: string
          status?: string
          type?: string
        }
        Relationships: [
          {
            foreignKeyName: "rnd_transactions_budget_id_fkey"
            columns: ["budget_id"]
            isOneToOne: false
            referencedRelation: "rnd_budgets"
            referencedColumns: ["id"]
          },
        ]
      }
      rnd_trends: {
        Row: {
          competitors: string[]
          detected_at: string
          id: string
          impact: string
          opportunity: string
          relevance: number
          source: string
          status: string
          title: string
        }
        Insert: {
          competitors?: string[]
          detected_at?: string
          id?: string
          impact?: string
          opportunity?: string
          relevance?: number
          source?: string
          status?: string
          title: string
        }
        Update: {
          competitors?: string[]
          detected_at?: string
          id?: string
          impact?: string
          opportunity?: string
          relevance?: number
          source?: string
          status?: string
          title?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
