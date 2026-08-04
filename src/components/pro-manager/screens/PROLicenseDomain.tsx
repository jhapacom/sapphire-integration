import { usePMLicenses } from "@/hooks/useProManagerData";
import { PMEmpty, PMLoading, PMPanel, PMSection, StatusBadge, formatDay } from "../pm-ui";

export const PROLicenseDomain = ({ search = "" }: { search?: string }) => {
  const { data, isLoading } = usePMLicenses();
  const term = search.trim().toLowerCase();
  const licenses = (data ?? []).filter((row) =>
    term ? [row.user_code, row.license_type, row.domain, row.domain_status].join(" ").toLowerCase().includes(term) : true,
  );

  return (
    <PMSection
      title="License & domain"
      description="License bindings, verified domains and transfer requests. Transfers are recommended, never executed here."
    >
      <PMPanel>
        {isLoading ? (
          <PMLoading rows={4} />
        ) : licenses.length === 0 ? (
          <PMEmpty message="No license records match this search." />
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full min-w-[720px] text-sm">
              <thead>
                <tr className="border-b border-border text-left text-xs uppercase tracking-wide text-muted-foreground">
                  <th className="py-2 pr-4">Account</th>
                  <th className="py-2 pr-4">License type</th>
                  <th className="py-2 pr-4">Domain</th>
                  <th className="py-2 pr-4">Domain status</th>
                  <th className="py-2 pr-4">Expiry</th>
                  <th className="py-2">Transfer</th>
                </tr>
              </thead>
              <tbody>
                {licenses.map((row) => (
                  <tr key={row.id} className="border-b border-border/60 last:border-0">
                    <td className="py-2.5 pr-4 font-medium text-foreground">{row.user_code}</td>
                    <td className="py-2.5 pr-4 text-muted-foreground">{row.license_type}</td>
                    <td className="py-2.5 pr-4 text-muted-foreground">{row.domain}</td>
                    <td className="py-2.5 pr-4">
                      <StatusBadge value={row.domain_status} />
                    </td>
                    <td className="py-2.5 pr-4 text-muted-foreground">{formatDay(row.expiry)}</td>
                    <td className="py-2.5">
                      <StatusBadge value={row.transfer_status} />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </PMPanel>
    </PMSection>
  );
};