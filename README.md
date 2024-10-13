# Matthew Boyea's NixOS Config

## A NixOS configuration using disko, impermanence, & nix home manager.

These configuration files are to be used during the installation of [NixOS] to create my perferred Linux PC in a declarative manner.

* [Disko] is used to partition drives declaratively.
* [Impermanence] is used to wipe most of the filesystem on every boot, reverting non-declarative changes to the system.
* A user-level [Nix Home Manager] installation enables users to install programs and modify user preferences without root-level permissions.

### Fork Files

* [Fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository) so that you can keep a copy of your own files on GitHub.
  Then when I make updates later, you could easily merge them into your own changes.

### Install Operating System

First, a few notes for newbies to the Linux Console.

* You can type `man` before a command name to learn what it does.
  For example, `man ls` tells you all options for how to list a directory.
* To copy and paste in the console, you must use `Ctrl+Shift+C` and `Ctrl+Shift+V` respectively.
  This is because `Ctrl+C` cancels a program and `Ctrl+V` literally inserts the next character typed.
* You may temporarily install a different text editor to use instead of `nano`.
  I get `nvim` using `nix-shell -p neovim`.
  A more beginner-friendly option may be `notepadqq` using `nix-shell -p notepadqq`.
  Search for your favorites at [search.nixos.org](https://search.nixos.org/packages).

For a video to help you understand the installation process, see [Perfect NixOS | Impermanence Setup](https://www.youtube.com/watch?v=YPKwkWtK7l0) by Vimjoyer.
My thanks go out to him for helping me to learn NixOS.
Note that my process is different from his, so follow these instructions word for word after watching the video.

#### Prepare The Installer

* [Download a graphical NixOS installer](https://nixos.org/download/).
  Graphical NixOS installers have easier methods to connect to wireless internet networks.
* [Prepare the NixOS installer onto a flash drive](https://nixos.wiki/wiki/NixOS_Installation_Guide#Making_the_installation_media).
* [Boot the NixOS installer from the flash drive](https://nixos.wiki/wiki/NixOS_Installation_Guide#Booting_the_installation_media).
  Close the visual installer; we'll do everything in the Console.
* [Connect to the internet](https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking).
  I use `nmtui`.

#### Partition The Drives

* Download the bare disko configuration file using:
  ```sh
  curl https://raw.githubusercontent.com/mboyea/nixos-config/main/hosts/barenix/disko.nix -o /tmp/disko.nix
  ```
  **Note:** to paste into a terminal, use `Ctrl+Shift+V`.
* Modify the [disko](https://github.com/nix-community/disko) file as you see fit using `nano /tmp/disko.nix`.
  Note that the `swap` partition should be at least 1.5x the amount of RAM you have installed (check using `free -g -h -t`) if you want the PC to support hibernation.
* Find the `<disk_name>` you want to install NixOS onto using `lsblk`.
  You're looking for something like `vda`, `sda`, `nvme0`, or `nvme0n1`.
* Partition your disk using:
  ```sh
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/<disk_name>"'
  ```

#### Install (Bare) NixOS

* Generate bare NixOS configuration files using:
  ```sh
  sudo nixos-generate-config --no-filesystems --root /mnt
  sudo rm -r /mnt/etc/nixos/configuration.nix
  sudo curl https://raw.githubusercontent.com/mboyea/nixos-config/main/hosts/barenix/configuration.nix -o /mnt/etc/nixos/configuration.nix
  sudo mv /tmp/disko.nix /mnt/etc/nixos
  ```
* Run `sudo nixos-install && reboot` and wait for the computer to boot into NixOS.
* Log in to user `admin` using password `admin`.
  It is now safe to disconnect the flash drive.

#### Configure NixOS

* [Connect to the internet](https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking).
  I use `nmtui`.
* Clone this repository (`<repo_path>`) into `~/.config/` using:
  ```sh
  mkdir ~/.config
  cd ~/.config
  git clone https://github.com/<repo_path>
  ```
* Generate complete NixOS configuration files for this host (`<host_name>`) using:
  ```sh
  cd ~/.config/nixos-config
  mkdir -p hosts/<host_name>
  cd ~/.config/nixos-config/hosts/<host_name>
  mv -t . /etc/nixos/hardware-configuration.nix /etc/nixos/disko.nix
  cp -t . ../maybenixlaptop/configuration.nix ../maybenixlaptop/flake.nix
  ```
* Create symlinks to this host's config files using:
  ```sh
  cd ~/.config/nixos-config
  ln -s -t . hosts/<host_name>/configuration.nix hosts/<host_name>/disko.nix hosts/<host_name>/flake.nix hosts/<host_name>/hardware-configuration.nix
  ```
* Modify the configuration file to specify your `<host_name>` using `nano ~/.config/nixos-config/configuration.nix`:
  ```nix
  # For help editing Nix config files, use any of the following
  #  man configuration.nix
  #  nixos-help
  #  https://search.nixos.org/options
  #  https://mynixos.com/search
  
  { config, lib, pkgs, inputs, ... }: {
    imports = [
      ./hardware-configuration.nix
      ./modules
      ./users
    ];
  
    networking.hostName = "<host_name>";
  
    environment = {
      systemPackages = with pkgs; [
        git
        gh
        home-manager
      ];
    };

    # do not modify the following
    system.stateVersion = <leave_as_default_value>;
  }
  ```
* Modify the flake file to specify your `<host_name>` and `<disk_name>`  using `nano ~/.config/nixos-config/flake.nix`:
  ```nix
  {
    <...>
    outputs = { nixpkgs, ... } @ inputs:
    let
      <...>
      hostName = "<host_name>";
      diskName = "<disk_name>";
    in {
      <...>
    };
  }
  ```
* Replace the directory `/etc/nixos` with a symlink to the configuration directory using:
  ```sh
  sudo rm -r /etc/nixos
  sudo ln -s ~/.config/nixos-config /etc/nixos
  ```
* Run `sudo nixos-rebuild boot && reboot`.
* Log in to user `admin` using password `admin`.

### Create & Modify Users

#### Overwrite Admin Password

#### Create New User

### Install User Preferences

* See [my preferred Nix Home Manager config](https://github.com/mboyea/home-manager).

### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

[NixOS]: https://nixos.org/
[Disko]: https://nixos.wiki/wiki/Disko
[Impermanence]: https://github.com/nix-community/impermanence
[Nix Home Manager]: https://github.com/nix-community/home-manager

