{ config, pkgs, ... }:

{  
  imports =
    [
      ./hardware-configuration.nix
      ./hyprland.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "it_IT.UTF-8";
  console = {
  # font = "Lat2-Terminus16";
    keyMap = "it";
  # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  xdg.portal.wlr.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # User account. Remember to set a password.
  users.users.lauro = {
    isNormalUser = true;
    home = "/home/lauro";
    extraGroups = [ "wheel" "networkmanager" ];
  };



  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget git neofetch htop xdg-user-dirs foot helix mako
    swaybg swaylock-effects swayidle grim slurp wl-clipboard
    wofi eww-wayland zsh starship xfce.thunar gvfs gnome.file-roller
    xfce.thunar-archive-plugin gsettings-desktop-schemas python3
    playerctl brightnessctl firefox maple-mono-NF hackgen-nf-font
    # nerdfonts
  ];
  
  fonts.fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "UbuntuMono" ]; })    
    maple-mono-NF hackgen-nf-font  
  ];
  

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.gvfs.enable = true;

  
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
  system.stateVersion = "22.11"; # Did you read the comment?

}

