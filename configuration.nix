{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.nix-ld.enable = true;
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

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

  users.users.tverdyy = {
    isNormalUser = true;
    description = "tverdyy";
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

}
