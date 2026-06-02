{ config, ... }:
{
    systemd.tmpfiles.rules = [
        "d /volumes 0777 root root - -"
        "d /volumes/homeassistant 0777 root root - -"
    ];
    sops.secrets.zwave.mode = "0666";
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
    networking.firewall.allowedTCPPorts = [
        8123 # HomeAssistant main
        3000 # zwave
    ];
    services.zwave-js = {
        enable = true;
        port = 3000;
        serialPort = "/dev/ttyAMA0";
        secretsConfigFile = config.sops.secrets.zwave.path;
    };
}   
