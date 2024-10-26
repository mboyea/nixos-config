{ config, lib, pkgs, inputs, ... }: {
  time.timeZone = lib.mkDefault "America/Chicago";
  services.automatic-timezoned.enable = true;
}

