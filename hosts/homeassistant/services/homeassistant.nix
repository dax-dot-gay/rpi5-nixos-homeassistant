{ config, ... }:
{
    systemd.tmpfiles.rules = [
        "d /volumes 0777 root root - -"
        "d /volumes/homeassistant 0777 root root - -"
        "d /volumes/esphome 0777 root root - -"
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
        containers.esphome = {
            volumes = [
                "/volumes/esphome:/config"
            ];
            image = "ghcr.io/esphome/esphome";
            extraOptions = [ "--network=host" ];
        };
    };
    networking.firewall.allowedTCPPorts = [
        8123 # HomeAssistant main
        6052 # ESPHome
    ];
    services.zwave-js = {
        enable = true;
        port = 3000;
        serialPort = "/dev/serial/by-id/usb-1a86_USB_Single_Serial_5A49038987-if00";
        secretsConfigFile = config.sops.secrets.zwave.path;
    };
}   
