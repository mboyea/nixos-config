Matthew Boyea's NixOS Config
===
A NixOS configuration using disko, impermanence, & nix home manager.
---
These configuration files are to be used during the installation of [NixOS] to create my perferred Linux PC in a declarative manner.
* [Disko] is used to partition drives declaratively.
* [Impermanence] is used to wipe most of the filesystem on every boot, reverting non-declarative changes to the system.
* A user-level [Nix Home Manager] installation enables users to install programs and modify user preferences without root-level permissions.

My personal [Nix Home Manager] configuration is also supplied to install my preferred rice (software & dotfiles).
While intended to be used within [NixOS], the Home Manager configuration may work in other operating systems using Hyprland.

### Fork System Files
* [Fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository) so that you can keep a copy of your local system changes on GitHub.

### Install System
* TODO: Prepare installation medium.
* TODO: Boot from installation medium.
* TODO: Connect to the internet.
* TODO: [Clone the forked repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository#cloning-a-repository) into directory `/mnt/etc/`.
* TODO: generate hardware-configuration.nix
* TODO: modify disko partition
* TODO: apply disko partition
* TODO: overwrite user `admin` password
* Run `sudo nixos-rebuild boot && reboot`
* Log in to user `admin` using the password you set.

### Create Users
* TODO: Add users

### Install User Preferences
* [Clone the forked repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository#cloning-a-repository) into directory `/home/mboyea/.config`
* [my preferred programs & dotfiles](https://github.com/mboyea/home-manager).
* TODO: Implement user Home Managers
* Run `home-manager switch`

### Contribute
Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

[NixOS]: https://nixos.org/
[Disko]: https://nixos.wiki/wiki/Disko
[Impermanence]: https://github.com/nix-community/impermanence
[Nix Home Manager]: https://github.com/nix-community/home-manager

