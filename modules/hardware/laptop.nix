{ config, lib, pkgs, inputs, ... }: {
  # boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  # hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  # don't suspend on lid close
  services.logind.lidSwitchExternalPower = "ignore";
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=yes
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
