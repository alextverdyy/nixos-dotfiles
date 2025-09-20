{ config, pkgs, inputs, lib, ... }:
let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    hypr = "hypr";
    hyprpanel = "hyprpanel";
  };

  configJson =
    builtins.fromJSON (builtins.readFile ./config/hyprpanel/config.json);
  themeJson =
    builtins.fromJSON (builtins.readFile ./config/hyprpanel/theme.json);
  hyprpanelSettings = configJson // themeJson;

  baseConfigs = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink ./config/${subpath};
      recursive = true;
    })
    configs;

  hyprpanelConfig = {
    "hyprpanel/config.json".text = builtins.toJSON hyprpanelSettings;
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

  xdg.configFile = lib.recursiveUpdate baseConfigs hyprpanelConfig;

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
    libsForQt5.dolphin
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
