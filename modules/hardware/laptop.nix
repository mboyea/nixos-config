{ config, lib, pkgs, inputs, ... }: {
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  services.logind.lidSwitchExternalPower = "ignore";
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=yes
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
