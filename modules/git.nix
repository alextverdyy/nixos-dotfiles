{ ... }: {
  programs.git = {
    enable = true;
    userName = "Oleg Tverdyy Tereshchenko";
    userEmail = "alexverdyy@gmail.com";

    extraConfig = { credential.helper = "!gh auth git-credential"; };
  };

}
