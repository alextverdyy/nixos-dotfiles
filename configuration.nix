{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.nix-ld.enable = true;
  boot.loader.systemd-boot.enable = false;

  # Activamos GRUB en UEFI
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev"; # EFI, no toca discos
  boot.loader.grub.efiSupport = true; # necesario para UEFI
  boot.loader.grub.useOSProber = true; # detecta Windows u otras distros

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";
  services = {

    displayManager = { ly.enable = true; };

    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
    };

    picom.enable = true;
  };

  programs.fish.enable = true;

  users.users.tverdyy = {
    isNormalUser = true;
    description = "tverdyy";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ tree ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.thunar.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    solargraph
    xclip
    typescript
    kitty
    lazygit
    hyprland-autoname-workspaces
    inotify-tools
    os-prober
    efibootmgr
    fish
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

}
