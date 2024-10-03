{ config, lib, pkgs, inputs, ... }: {
  time.timeZone = lib.mkDefault "America/Chicago";
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
}

