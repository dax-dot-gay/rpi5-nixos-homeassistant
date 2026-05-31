{ ... }:
{
    networking.firewall.allowedTCPPorts = [
        80
        443
    ];
    security.acme = {
        acceptTerms = true;
        defaults.email = "me@dax.gay";
    };
    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."home.maine.dax.gay" = {
            enableACME = true;
            forceSSL = true;
            locations."/" = {
                proxyPass = "http://0.0.0.0:8123";
                proxyWebsockets = true;
            };
        };
    };
}
