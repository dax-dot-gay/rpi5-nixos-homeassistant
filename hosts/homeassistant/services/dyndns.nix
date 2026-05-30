{ config, ... }:
{
    sops.secrets.dyndns = {
        mode = "0444";
    };
    services.ddns-updater = {
        enable = true;
        environment = {
            SERVER_ENABLED = "no";
            CONFIG_FILEPATH = config.sops.secrets.dyndns.path;
            PERIOD = "5m";
            LOG_LEVEL = "debug";
        };
    };
}
