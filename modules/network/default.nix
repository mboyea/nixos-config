{ config, lib, pkgs, inputs, ... }: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  security.polkit.enable = true;

  time.timeZone = lib.mkDefault "America/Chicago";
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  # hardware.bluetooth.hsphfpd.enable = true; # incompatible with pipewire.wireplumber

  # automount usb drives
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

}

