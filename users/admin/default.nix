{
  users.users.admin = {
    # set the admin user password to "admin" using the following one-liner:
    # mkpasswd -m sha-512 admin | sed 's/\(\S*\).*/"\1"/' > ~/.config/nixos/users/admin/pass.nix
    hashedPassword = import ./pass.nix;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "audio" "video" ];
    useDefaultShell = true;
  };

  systemd.tmpfiles.rules = [
    "d /persist/users/home/admin 0700 admin users -"
    # "L+ /etc/nixos/users/admin/home-manager - - - - /home/admin/.config/home-manager"
  ];

  environment.persistence."/persist/users" = {
    hideMounts = true;
    directories = [
      "/home/admin"
    ];
    # DECLARATIVE PERSISTENCE EXAMPLE:
    # users.admin = {
    #   directories = [
    #     "code"
    #     "desktop"
    #     "documents"
    #     "downloads"
    #     "images"
    #     "music"
    #     "videos"
    #     ".config"
    #     # the following directories are essential
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

