{
  users.users.admin = {
    # set the admin user password to "admin" using the following one-liner:
    # mkpasswd -m sha-512 admin | sed 's/\(\S*\).*/"\1"/' >> <path_to_config>/users/admin/pass.nix
    hashedPassword = import ./pass.nix;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  }

  systemd.tmpfiles.rules = [
    "d /persist/users/home/admin 0700 admin users -"
    # "L+ /etc/nixos/users/admin/home-manager - - - - /home/admin/.config/home-manager"
  ];

  environment.persistence."/persist/users" = {
    hideMounts = true;
    directories = [
      "/run/user"
      "/home/admin"
    ];
    # DECLARATIVE PERSISTENCE EXAMPLE:
    # users.username = {
    #   directories = [
    #     "code"
    #     "docs"
    #     "downloads"
    #     "imgs"
    #     "music"
    #     "vids"
    #     ".config"
    #     # do not remove the following directories
    #     ".config/home-manager"
    #     ".config/nix"
    #     ".local/state/home-manager"
    #     ".local/state/nix"
    #     ".local/share/home-manager"
    #     ".local/share/nix"
    #   ];
    # };
  };
}
