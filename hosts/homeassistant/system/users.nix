{ config, ... }:
{
    sops.secrets.password.neededForUsers = true;
    users.users.rpi = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.password.path;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAiAboVZPRR/NJirG0zeB3SBdOYzJ1n3/kYKKRDGu3wq dax@dax.gay"
        ];
    };
    services.getty.autologinUser = "rpi";
}
