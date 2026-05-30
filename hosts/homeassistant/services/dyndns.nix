{ config, ... }:
{
    sops.secrets.dyndns = {
        mode = "0444";
    };
    services.ddclient = {
      enable = true;
      passwordFile = config.sops.secrets.dyndns.path;
      interval = "5min";
      protocol = "namecheap";
      username = "dax.gay";
      domains = ["home.maine.dax.gay"];
      ssl = true;
    };
}
