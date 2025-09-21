{ config, pkgs, ... }: {
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
