{ config, lib, pkgs, inputs, ... }: {
  networking = {
    hostName = "maybenixlaptop";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  security.polkit.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  # hardware.bluetooth.hsphfpd.enable = true; # incompatible with pipewire.wireplumber

  # automount usb drives
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

}

