{ config, ... }:
{
    sops.secrets.dyndns = {
        mode = "0444";
    };
    services.ddclient = {
      enable = true;
      interval = "5min";
      configFile = config.sops.secrets.dyndns.path;
    };
}
