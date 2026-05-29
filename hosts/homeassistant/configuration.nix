{ ... }:
{
  imports = [
    ./rpi.nix
    ./users.nix
    ./base.nix
    ./fs.nix
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  nix.settings.trusted-users = ["root" "rpi"];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.hostName = "homeassistant";
  system.stateVersion = "25.11";
}
