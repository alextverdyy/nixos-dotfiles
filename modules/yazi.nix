{inputs, ...}: {
  imports = [
    (inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default)
  ];

  programs.yazi = {
    enable = true;
  };

  programs.yazi.yaziPlugins = {
    enable = true;
    plugins = {
      starship.enable = true;
      git.enable = true;
      max-preview.enable = true;
      ouch.enable = true;
      smart-enter.enable = true;
      system-clipboard.enable = true;
      smart-filter.enable = true;
      full-border.enable = true;
      jump-to-char = {
        enable = true;
        keys.toggle.on = ["F"];
      };
      relative-motions = {
        enable = true;
        show_numbers = "relative_absolute";
        show_motion = true;
      };
    };
  };
}
