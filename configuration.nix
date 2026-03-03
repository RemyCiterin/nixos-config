# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home-manager.nix
      ./app/vim.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.dhcpcd.enable = true;
  networking.hostName = "the_game"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
       General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;

#  networking.nameservers = [
#      "78.47.220.84#b.cyberiadot.invalid"
#      "2a01:4f8:1c17:4d9b::853#b.cyberiadot.invalid"
#      "193.218.118.66#c.cyberiadot.invalid"
#      "2a0f:e586:f:fa01::2#c.cyberiadot.invalid"
#  ];
#
#  security.pki.certificates = [
#       "b.cyberiadot.invalid
#-----BEGIN CERTIFICATE-----
#MIIBazCB8QIJAKClsF7wQoxJMAoGCCqGSM49BAMCMB8xHTAbBgNVBAMMFGIuY3li
#ZXJpYWRvdC5pbnZhbGlkMB4XDTIwMDIxNDAzMDAxNloXDTMwMDIxMTAzMDAxNlow
#HzEdMBsGA1UEAwwUYi5jeWJlcmlhZG90LmludmFsaWQwdjAQBgcqhkjOPQIBBgUr
#gQQAIgNiAARd1SLczOZ2IP8SW2o0LxWq7iXXuWc4dhh9fTdpOk7cUXFop9LKYlZ2
#I2TKAfc/oaN4G60Lpw5avCMeqeFLhL6n2g6ODw5qVsLlj31LIV3Tz7L3MzZ9XiUa
#0rCnKQJp2qIwCgYIKoZIzj0EAwIDaQAwZgIxAMIBJcS0aA+5K2Hc7OJXaSq+CAaP
#z3Ukj2qFTWCe+rxwzoRuUbZIF8rL36lisSaxkQIxAOHogJ1L8FhmeFIreWv3I0cE
#DkWcoldNslvpaLGpKb0lrwoPa6OAf6jqetJdJqwjWw==
#-----END CERTIFICATE-----"
#
#      "c.cyberiadot.invalid
#-----BEGIN CERTIFICATE-----
#MIIEujCCAqICCQC0LyDZzYyWHTANBgkqhkiG9w0BAQsFADAfMR0wGwYDVQQDDBRj
#LmN5YmVyaWFkb3QuaW52YWxpZDAeFw0yMTAyMDMyMjM5MTZaFw0zMTAyMDEyMjM5
#MTZaMB8xHTAbBgNVBAMMFGMuY3liZXJpYWRvdC5pbnZhbGlkMIICIjANBgkqhkiG
#9w0BAQEFAAOCAg8AMIICCgKCAgEA61hLzAI8FB5EpEqMOrQX/PGa8qlbfnZhXQl2
#schi6xymS8DKbfAvvpeHWiycQHDHkj3sGhPzAfeVr7v4CoCTAnBohwHT/LsDlU6O
#xct1b2/rS4tM1s1GqdShbG/oCQTkz3ME5vJhfBMVe8QxuGHAo36tWCnjIYJVG6Nb
#1XuswcLxnqNlDhPs7tQrSzUjAaudZ/C4QW5dSz3h1mbVrjqfeY7YWu8P+x+kl90r
#7IOPpNRaJCNXf18ArGdzD6u4PLVbDp8b2UfDYbgE+I03qziYakDCxMV/89rClKdI
#r46MCuUsF3EsrzFk01GYTQI8FgPXEyksLVY0D7HQVKc5ThCSvPFm6sSh3r82RE89
#6F4KdZwzl3te1c6pjLJY8zjgllULZ5ilUCyHpKHLuWuxiLvFAmoznrpjCDNpHQGh
#FmklFoGXnT9HAmu4VKX6623QgI8yuB1SHsIZyDgXfOUwCK/n1JFce6VXpwyHAXGi
#DJW7KF/l/Ghavplx1y4hlTrM1ysak27NPDFY4wNr4WWQ43O10N1q71CmXhQgwNBk
#jgsSX78IU+eDdQGgugK8CIFenWuOFBeVxX04wObzETMCu5Lf7OonhNPiyMn2b80d
#HYP5mE4FdWnYp4+gZUQ51DpLtUFn2zUe/AKco1M1x0Z7KTT/DT4inWVKEZ76maCp
#6YEYgkMCAwEAATANBgkqhkiG9w0BAQsFAAOCAgEAsFUf8pcM+3Zk1bhWW1TY/a3u
#xFnv99FAM8Rv9mj73H3jz4eNlDVVPPlqFzn5WCGnVZ6+4lN+sAGIFNMyDQeFpwkw
#ffI1lQ/kAZpPkU3Oc3JUhEC9/obV4ShSPK16/tKLkN90pfdG7sokD2fxfFyHmuAR
#cnuZz/X/w11GcwajxsCl2hVunUlZ7qibyy+M0ut90Rq8eJNVrkkvvDi0Zl3n/Ap+
#Upx7/nZ2IoCyGVlsS/qBRDfRu1wAfRqkBowyKI3vChOzmY+aHnmB5iBAETcxbMJy
#5BDFIQexH2+TJQgL/UigkvTGtQ7hKS18thHQTQRnFVy7tlzPrsbtFGgmot27DhyB
#qEPFKisv7FAju0W5U2yK1fNnvmqfJ75vph49qzV0bgXqreuwHmnTjEx22s+79qn8
#uTVJPcbUGsivfeOXRivImVFU/zmkvKG5CsFIaB2CckJhWBn8cqEyyKoA6N06H2qs
#hJ9pylVKWpTmyqcxo2q73qTCRF+c090uA0bdYQ84emDMKdrkBMvSUDaolyB/iEGk
#pBy26UGzHmtWSegvoFmA/+Devt3WJ8Ci/g9TmDViFnv0ec+rhox20gJMcj/QBPwe
#WZ6mmmXJlZIT3KYCbKZ2d0VR0Dj7UsgYcxRhjSKE6ZrWA7KRgzsxlph+Esjv6fdP
#gZUM6dx5WBF8sbBlCNg=
#-----END CERTIFICATE-----"
#  ];
#
#  services.resolved = {
#	  enable=true;
#    dnssec="true";
#    dnsovertls="true";#"opportunistic";
#    domains=["~."];
#    fallbackDns=[];
#  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";


  #nixpkgs.config.permittedInsecurePackages = [
  #  "openssl-1.1.1t"
  #];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr"; # lib.mkForce "fr";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  programs.river.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Screen recording
  # xdg.portal = {
  #   xdgOpenUsePortal = true;
  #   enable = true;

  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-wlr
  #   ];
  # };

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.remy = {
    isNormalUser = true;
    extraGroups = [ "audio" "wheel" "dialout" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
  ];

  # waylock
  security.pam.services.waylock.unixAuth = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    python312Packages.dbus-python
    python312

    discord

    ffmpeg

    virt-manager
    libfaketime

    #xdg-desktop-portal-wlr
    ghc
    btop
    cabal-install
    brightnessctl
    pamixer
    waylock
    i3bar-river
    i3status-rust
    acpi # check battery level
    vim
    foot
    wget
    firefox
    thunderbird
    htop
    cmake
    gnumake
    ocaml
    signal-desktop
    asha-pipewire-sink
    git
    coq
    tldr
    torrential
    rust-analyzer
    wf-recorder
    idris2
    # texlive.combined.scheme-full
    # clang-tools
    # julia-bin
    elan
    rustup
    fstar
    # why3
    z3
    gcc
    # cubicle
    zathura
    zig
    zls
    # sage
    # qFlipper
    qemu
    # ghc
    # bintools-unwrapped
    openssl
    spotify
    pulseaudio
    nodejs
    typst
    # the-powder-toy
    # prismlauncher
    # tokei
    # steam
    ghidra
    radare2
    unzip
  ];

  networking.firewall.allowedTCPPorts = [ 4242 22 3128 ];
  networking.firewall.allowedUDPPorts = [ 65482 ];

  services.openssh.enable = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

