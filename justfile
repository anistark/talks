# talks — local preview

port := "8080"

# Show available recipes.
default:
    @just --list

# Serve the site at http://localhost:8080
web:
    @echo "serving http://localhost:{{port}} — ctrl-c to stop"
    @python3 -m http.server {{port}} --bind 127.0.0.1

# Same, but bound to every interface — reachable over LAN, Tailscale, etc.
web-host:
    @echo "serving on all interfaces, port {{port}} — ctrl-c to stop"
    @ipconfig getifaddr en0 2>/dev/null | sed 's|^|  lan:       http://|;s|$|:{{port}}|' || true
    @tailscale ip -4 2>/dev/null | sed 's|^|  tailscale: http://|;s|$|:{{port}}|' || true
    @python3 -m http.server {{port}} --bind 0.0.0.0
