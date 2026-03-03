{config, pkgs, ...}:
# let
#   home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
# in
{
  imports = [
    <home-manager/nixos>
  ];

  # configure home-manager
  home-manager.users.remy = {
    home.stateVersion = "24.05";


    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraConfig = ''
        (defun my-fstar-compute-prover-args-using-make ()
          "Construct arguments to pass to F* by calling make."
          (with-demoted-errors "Error when constructing arg string: %S"
            (let* ((fname (file-name-nondirectory buffer-file-name))
             (target (concat fname "-in"))
             (argstr (condition-case nil
          	       (car (process-lines "make" "--quiet" target))
          	     (error "--debug Low"))))
              (split-string argstr))))

        (setq fstar-subp-prover-args #'my-fstar-compute-prover-args-using-make)

        (add-to-list 'tramp-remote-path "/run/current-system/sw/bin/z3")
        (add-to-list 'tramp-remote-path "/run/current-system/sw/bin/fstar.exe")
      '';

      extraPackages = (epkgs: [
        epkgs.fstar-mode
        epkgs.tramp
      ]);
    };
  };
}
