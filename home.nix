{ config, pkgs, inputs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  user = "tverdyy";

  configs = {
    qtile = "qtile";
    nvim = "nvim";
    hypr = "hypr";
    waybar = "waybar";
  };
in
{
  imports = [ ./modules/neovim.nix ./modules/git.nix ];
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      logout = "sudo pkill -KILL -u ${user}";
      nix-files = "cd ~/nixos-dotfiles && nvim";
    };
  };

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
  ];

  programs.waybar.enable = true;

}
