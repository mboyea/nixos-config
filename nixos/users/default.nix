{
  imports = [
    ./admin
  ];

  users.mutableUsers = false;

  systemd.tmpfiles.rules = [
    "d /persist/users/ 0777 root root -"
  ];
}