{ ... }:
{
    imports = [
        ./homeassistant.nix
        ./dyndns.nix
        ./nginx.nix
        ./tailscale.nix
    ];
}
