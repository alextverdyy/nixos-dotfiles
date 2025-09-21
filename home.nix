{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  user = "tverdyy";

  configs = {
    nvim = "nvim";
    hypr = "hypr";
    waybar = "waybar";
    wofi = "wofi";
    hyprland-autoname-workspaces = "hyprland-autoname-workspaces";
    kitty = "kitty";
    tmux = "tmux";
    fish = "fish";
  };
in
{
  imports = [ ./modules/neovim.nix ./modules/git.nix ];
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    gnumake
    luajit
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    rofi
    xwallpaper
    cargo
    nodejs
    go
    unzip
    ruby
    fzf
    gh
    kitty
    wofi
    hyprpaper
    hyprcursor
    phinger-cursors
    wl-clipboard
    btop
    wofi
    hyprland-autoname-workspaces
    starship
    tmux
    eza
    sesh
    gum
    yq
  ];

  programs.waybar.enable = true;

}
