{ config, pkgs, inputs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    hypr = "hypr";
    hyprpanel = "hyprpanel";
  };
in
{
  home.username = "tverdyy";
  home.homeDirectory = "/home/tverdyy";
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
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
  ];

  programs.hyprpanel = { enable = true; };

  programs.git = {
    enable = true;
    userName = "Oleg Tverdyy Tereshchenko";
    userEmail = "alexverdyy@gmail.com";

    extraConfig = { credential.helper = "!gh auth git-credential"; };
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      cmake
      tree-sitter
      nodejs
      yarn
      unzip
      (python3.withPackages (ps: with ps; [ pynvim ]))
    ];
  };

}
