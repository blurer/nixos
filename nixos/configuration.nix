# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # xserver
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = false;
  hardware.trackpoint.enable = true;
  hardware.trackpoint.device = "Elan Trackpoint";


  networking.hostName = "bl-lt";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bl = {
    isNormalUser = true;
    description = "Bryan Lurer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

    # nopasswd sudo
  security.sudo.extraRules= [
    {  users = [ "bl" ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ]; 
        }
      ];
    }
  ];

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

# cron
services.cron = {
   enable = true;
   systemCronJobs = [
    "*/5 * * * *      root    date >> /tmp/cron.log"
   ]; 
};


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    alacritty
    xterm
    python310
    xorg.xbacklight
    i3status
    polybar
    i3
    rofi
    dmenu
    vim 
    wget
    curl
    git
    htop
    i3lock
    pkgs.networkmanagerapplet
    obs-studio
    python
    rsync
    rclone
    neovim
    discord
    neofetch
    scrot
    arandr
    awscli
    bat
    nload
    iperf3
    protonvpn-cli
    wireguard-tools
    whois
    mtr
    feh
    dunst
    remmina
    terraform
    zathura
    nitrogen
    tcpdump
    xfce.thunar
    libgnome-keyring
    unrar
    p7zip
    jq
    fzf
    bat
    cryptsetup
    pcmanfm
    obsidian
    pavucontrol
    haskellPackages.network-manager-tui
    spotify
    btop
    wavemon
    ansible
    pkgs.gnome3.gnome-tweaks
    lxappearance
    _1password-gui
    vscode
    ranger
    zsh
    unzip
  ];

   fonts.fonts = with pkgs; [
      corefonts
      inconsolata
      unifont
      ubuntu_font_family
      symbola
      nerdfonts
      freefont_ttf
      powerline-fonts
      font-awesome
      font-awesome_4
      dejavu_fonts
      google-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
    ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

services.xserver.videoDrivers = [ "modesetting" ];
services.xserver.useGlamor = true;

}
