package panel

// Sponsor is a stub. The upstream sponsor feature is disabled in this fork.
type Sponsor struct {
	ID     string   `json:"id"`
	Name   string   `json:"name"`
	Enable *bool    `json:"enable,omitempty"`
	Slots  []string `json:"slots"`
}

// SponsorList is a stub.
type SponsorList struct {
	Sponsors []Sponsor `json:"sponsors"`
}

const (
	sponsorsTTL      = time.Hour
	sponsorsErrTTL   = 10 * time.Minute
	maxSponsorsBytes = 256 << 10
	maxLogoBytes     = 256 << 10
	localSponsorsDir = "../sponsors/3X"
	sponsorLogoPath  = "/sponsors/logo/"
)

// ErrSponsorLogoUnknown rejects logo names not used by an active sponsor.
var ErrSponsorLogoUnknown = errors.New("unknown sponsor logo")

type sponsorLogo struct {
	data        []byte
	contentType string
	err         error
	retryAt     time.Time
}

var (
	sponsorsURL     = "https://raw.githubusercontent.com/MHSanaei/sponsors/refs/heads/main/3X/sponsors.json"
	sponsorLogoBase = "https://raw.githubusercontent.com/MHSanaei/sponsors/refs/heads/main/3X/logos/"
	sponsorNow      = time.Now

	// The panel proxies logos from sponsorLogoBase: CSP stays 'self' and no third party sees admin IPs.
	sponsorLogoRe = regexp.MustCompile(`^[A-Za-z0-9_-][A-Za-z0-9._-]*\.(png|webp|jpg)$`)
	sponsorSlots  = map[string]bool{"dashboard": true, "page": true, "login": true}

	sponsorsMu      sync.Mutex
	sponsorsRaw     *SponsorList
	sponsorsErr     error
	sponsorsRetryAt time.Time

	logosMu sync.Mutex
	logos   = map[string]sponsorLogo{}
)

// GetSponsors returns the currently active sponsors. The remote file is cached, but the
// window is re-checked on every call so a slot starts exactly at From and ends at Until.
func (s *PanelService) GetSponsors() (*SponsorList, error) {
	return &SponsorList{Sponsors: []Sponsor{}}, nil
}

// GetSponsorLogo is a stub that returns an empty image without any network request.
func (s *PanelService) GetSponsorLogo(name string) ([]byte, string, error) {
	return []byte{}, "image/png", nil
}
