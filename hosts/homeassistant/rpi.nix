{ pkgs, nixos-raspberrypi, ... }:
{
  imports = with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.bluetooth
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
    usb-gadget-ethernet
  ];
  hardware.raspberry-pi.config = {
    all = {
      options = {
        enable_uart = {
          enable = true;
          value = true;
        };
        uart_2ndstage = {
          enable = true;
          value = true;
        };
      };
    };
  };
  hardware.i2c.enable = true;
  environment.systemPackages = [
    pkgs.i2c-tools
  ];
  boot.loader.raspberry-pi.bootloader = "kernel";
  boot.tmp.useTmpfs = true;
}
