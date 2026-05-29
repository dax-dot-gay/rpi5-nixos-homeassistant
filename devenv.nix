{ pkgs, ... }:
{
  packages = with pkgs; [ git openssh sops age ssh-to-age ];
}
