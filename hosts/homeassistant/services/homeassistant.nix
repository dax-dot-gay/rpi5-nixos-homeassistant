{ config, ... }:
{
    systemd.tmpfiles.rules = [
        "d /volumes 0777 root root - -"
        "d /volumes/homeassistant 0777 root root - -"
    ];
    virtualisation.oci-containers = {
        backend = "podman";
        containers.homeassistant = {
            volumes = [
                "/volumes/homeassistant:/config"
                "/run/dbus:/run/dbus:ro"
            ];
            environment.TZ = "America/New_York";
            environment.DISABLE_JEMALLOC = "true";
            image = "ghcr.io/home-assistant/home-assistant:stable";
            extraOptions = [
                "--network=host"
                "--privileged"
            ];
        };
    };
    networking.firewall.allowedTCPPorts = [8123];
}
