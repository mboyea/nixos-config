# Matthew Boyea's NixOS Config

## A NixOS configuration using disko, impermanence, & nix home manager.

These configuration files are to be used during the installation of [NixOS] to create my perferred Linux PC in a declarative manner.

* [Disko] is used to partition drives declaratively.
* [Impermanence] is used to wipe most of the filesystem on every boot, reverting non-declarative changes to the system.
* A user-level [Nix Home Manager] installation enables users to install programs and modify user preferences without root-level permissions.

### Fork Files

* [Fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository) so that you can keep a copy of your own files on GitHub.
  Then when I make updates later, you could easily merge them into your own changes.

### Install System

For a video to help you understand the installation process, see [Perfect NixOS | Impermanence Setup](https://www.youtube.com/watch?v=YPKwkWtK7l0) by Vimjoyer.
My thanks go out to him for helping me to learn NixOS.
Note that my process is slightly different from his, so follow these instructions word for word after watching the video.

* [Download the graphical NixOS installer](https://nixos.org/download/#graphical-iso-image).
* [Prepare the NixOS installer onto a flash drive](https://nixos.wiki/wiki/NixOS_Installation_Guide#Making_the_installation_media).
* [Boot the NixOS installer from the flash drive](https://nixos.wiki/wiki/NixOS_Installation_Guide#Booting_the_installation_media).
  Close the visual installer; we'll do everything in a terminal.
* [Connect to the internet](https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking).
* You may install your favorite text editor to use instead of `nano`.
  I get `nvim` using `nix-shell -p neovim`.
* Download a flake and disko file to build off of using:
  ```sh
  curl https://raw.githubusercontent.com/mboyea/nixos-config/main/hosts/maybenixlaptop/disko.nix -o /tmp/disko.nix
  curl https://raw.githubusercontent.com/mboyea/nixos-config/main/hosts/maybenixlaptop/flake.nix -o /tmp/flake.nix
  ```
* Modify the disko file as you see fit using `nano /tmp/disko.nix`.
  Note that the `swap` partition should be at least 1.5x the amount of RAM you have installed (check using `free -g -h -t`) if you want the PC to support hibernation.
* Find the disk you want to install NixOS onto using `lsblk`.
  You're looking for something like `vda`, `sda`, `nvme0`, or `nvme0n1`.
* Partition your disk using:
  ```sh
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"dev/<disk_name>"'`
  ```
* Generate the default NixOS configuration using `sudo nixos-generate-config --no-filesystems --root /mnt`
* Install git using `nix-shell -p git`.
* Clone this repository into `/mnt/etc/nixos` using:
  ```sh
  cd /mnt/etc/nixos
  git init
  git remote add origin https://github.com/mboyea/nixos-config
  git fetch
  git reset --mixed origin/main
  ```
* Move your config files into a new host directory using:
  ```sh
  cd /mnt/etc/nixos
  mkdir hosts/<host_name>
  mv -t hosts/<host_name> /tmp/disko.nix /tmp/flake.nix configuration.nix hardware-configuration.nix
  ```
* Create symlinks to the config files using:
  ```sh
  cd /mnt/etc/nixos
  ln -s hosts/<host_name>/configuration.nix configuration.nix
  ln -s hosts/<host_name>/hardware-configuration.nix hardware-configuration.nix
  ln -s hosts/<host_name>/disko.nix disko.nix
  ln -s hosts/<host_name>/flake.nix flake.nix
  ```
* Modify your configuration using `nano /mnt/etc/nixos/configuration.nix` to contain:
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
        home-manager
      ];
    };
  
    system.stateVersion = <leave_as_default_value>;
  }
  ```
* Modify your flake using `nano /mnt/etc/nixos/flake.nix`:
  ```
  {
    <...>
    outputs = { nixpkgs, ... } @ inputs:
      let
        hostName = <host_name>;
        diskName = <disk_name>;
      in {
        <...>
      };
    };
  }
  ```
* Run `sudo nixos-rebuild boot && reboot`.
* Log in to user `admin` using password `admin`.

### Create Users

* TODO: overwrite user `admin` password
* TODO: Add users

### Install User Preferences

* See [my preferred Nix Home Manager config](https://github.com/mboyea/home-manager).

### TODO List

* Figure out settings file to declare hostname and other stuff for the `flake.nix` and `configuration.nix` to gobble up.

### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

[NixOS]: https://nixos.org/
[Disko]: https://nixos.wiki/wiki/Disko
[Impermanence]: https://github.com/nix-community/impermanence
[Nix Home Manager]: https://github.com/nix-community/home-manager

