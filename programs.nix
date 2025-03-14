{
  lib,
  pkgs,
  inputs,
  stablePkgs,
  ...
}:
{

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Thomas H. Surlykke";
        email = "54353246+angryluck@users.noreply.github.com";
      };
      alias = {
        a = "add .";
        cm = "commit -m";
        acm = "!git add . && git commit -m";
        ca = "!git add . && git commit -m 'empty'"; # commit with no msg
        st = "status";
        br = "branch";
        co = "checkout"; # Still not sure what this does...
        qp = "!git add . && git commit -m 'quick-commit' && git push"; # quick-push
        # acp = "!git add . && git commit -m 'empty' && git push";
      };
      push.autoSetupRemote = "true";
      init.defaultBranch = "master";
      # pull.rebase = "false";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.yazi = {
    enable = true;
    settings = {
      yazi.opener.open = [
        {
          run = "xdg-open \"$1\"";
          orphan = true; # Allows closing yazi, after opening a file (e.g. pdf)
          desc = "Open";
          for = "linux";
        }
        {
          run = "open \"$@\"";
          desc = "Open";
          for = "macos";
        }
        {
          run = "start \"\" \"%1\"";
          orphan = true;
          desc = "Open";
          for = "windows";
        }
      ];
      keymap.manager.prepend_keymap = [
        {
          on = "T";
          run = "shell \"$SHELL\"  --confirm --block --orphan";
          desc = "Open shell here";
        }
      ];
    };
  };

  programs.slock.enable = true;

  programs.nix-ld.enable = true;
  # For DIKU-Canvas to work (e.g. SDL2)
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib # This includes libstdc++
    xorg.libXrandr # X11 randr support
    libGL # OpenGL support
    SDL2

    xorg.libX11 # Basic X11 client
    xorg.libXcursor # X11 cursor management
    xorg.libXi # X11 Input Extension
    xorg.libXinerama # X11 Xinerama extension
    vulkan-loader # For Vulkan support
  ];

  users.users.angryluck.packages = with pkgs; [
    stow
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    ### FONTS
    _0xproto
    font-awesome
    inconsolata
    hack-font
    noto-fonts-color-emoji
    # noto-fonts-extra
    # otf-fira-mono
    terminus_font
    # ttf-aptos 1.0-1
    caladea
    noto-fonts
    lato
    font-awesome
    fira-sans
    julia-mono

    # nerd-fonts.NerdFontsSymbolsOnly
    nerd-fonts._0xproto
    nerd-fonts.symbols-only
    nerd-fonts.inconsolata
    nerd-fonts.hack

    # Aptos clone
    inter

    # Helvetica clones
    # tex-gyre-heros-fonts
    gyre-fonts
    # urw-base35-fonts # Includes Nimbus Sans
    aileron

    lato
    poppins

  ];

  # User specific:
  users.users.milla.packages =
    with pkgs;
    [
      libreoffice-qt
      ungoogled-chromium
      hunspell
      hunspellDicts.da_DK
      hunspellDicts.en_US
      hunspellDicts.en_GB-large
    ]
    ++ (with pkgs.pantheon; [
      elementary-calculator
      elementary-calendar
      elementary-camera
      elementary-code
      elementary-files
      elementary-mail
      elementary-music
      elementary-photos
      elementary-screenshot
      elementary-tasks
      elementary-terminal
      elementary-videos
      epiphany
    ]);

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "zoom-us"
    ];

  environment.systemPackages = with pkgs; [
    # nano # installed by default
    vim
    git
    wget
    curl
    nix-search-cli
    xclip
    hello

    # Needed for configuring eduroam (but not otherwise)
    networkmanagerapplet

    wezterm

    # UNFREE PACKAGES:
    discord
    zoom-us
    # gh-copilot # Not as helpful as I thought...

    # UNFREE END
    gh
    bitwarden-desktop

    ### CLI-tools
    neofetch
    trash-cli
    fzf
    bc
    htop
    # powertop
    # fd
    cowsay
    haskellPackages.misfortune
    # plocate
    # ripgrep
    zip
    unzip
    # wget
    xcolor
    xorg.xev
    xorg.xkill
    xorg.xprop
    killall
    file
    # Set in configuration.nix insted
    # brillo
    direnv

    ### Applications
    nautilus
    # dolphin

    # Trying stable version
    # Didn't work...
    stablePkgs.logseq

    ### Removed from unstable for now, have to install from elsewhere :/
    # logseq

    # Needed for logseq for some reason
    # glibc

    # Didn't work on unstable
    stablePkgs.isabelle
    stablePkgs.isabelle-components.isabelle-linter

    # virtualbox

    ### Utilities
    redshift
    # syncthing
    flameshot
    # wineWowPackages.stable
    rofi
    rofi-emoji
    # rofi-file-browser
    rofimoji
    rofi-calc
    # rofi-unwrapped
    # rofi-file-browser
    # rofi-emoji
    # rofimoji
    rofi-power-menu
    # rofi-calc

    # Terminal
    # wezterm

    ### Programming languages
    gcc14
    gnumake
    valgrind
    # gdb
    rars
    # fsharp
    # dotnet-sdk_7
    # dotnet-sdk
    # dotnet-sdk_9
    # dotnet-runtime
    # dotnet-aspnetcore
    # dotnet-repl
    # dotnetPackages.Nuget
    # dotnet-sdk
    # dotnetCorePackages.sdk_8_0_1xx

    ### IF YOU INSTALL THIS, THEN HASKELL-LANGUAGE-SERVER DOESN'T WORK!
    ### -> Must be because you then have two different ghc-versions...
    # ghc

    #FIX: Configure this with 'programs.texlive.enable' instead
    # texlive.combined.scheme-medium # Or 'full'

    texlive.combined.scheme-full
    # (texlive.combine {
    #   inherit (texlive)
    #     scheme-medium
    #     minted
    #     ;
    # })

    # Potential programs, but don't use them right now
    # Emacs (/doom)
    # gtk?
    # i3
    # kitty
    # kupfer
    # qalculate
    # Thunar
    # tmux
    # Virtualbox
    # vlc
    # zoom-us
    # bitwarden
    # pavucontrol
    # brillo
    # chromium
    # dmenu
    # flatpak
    # fswatch
    # gimp
    # iwd (shouldn't be needed)
    # jupyterlab
    # libreoffice-fresh
    # ly?
    # networkmanager (in configuration.nix)
    # nextcloud? (need own server first)
    # obsidian
    # p7zip
    # pamixer
    # pandoc
    # pdftk
    # ranger
    # rofimoji
    # sbctl (secureboot key manager)
    # slock
    # tlp (in configuration.nix)
    # ueberzugpp
    # wirelesstools

    ### From nvim-health-check (so might need to be moved there)
    xdotool
    ripgrep

    evtest

    time # time programs

    pdfgrep

    futhark

    # ?
    sshfs

    openconnect
    networkmanager-openconnect

    # til dpp (hendrix server)
    slurm

    # Citations
    zotero

    # test
    # haskellPackages.misfortune
    # libreoffice
    libreoffice-qt

    lazygit

    ispc
    # SDL.overrideAttrs
    # (old: { dontDisableStatic = true; })
    SDL2
    SDL2_ttf
    SDL2_image
    SDL2_net
    SDL2_Pango
    SDL2_gfx
    SDL2_mixer
    SDL2_sound
    gtk3
    # mesa

    # fsautocomplete

    # cudaPackages.cuda_gdb
    # For futhark
    # cudatoolkit
    # linuxKernel.packages.linux_6_6.nvidia_x11
    # opencl-headers
    # ocl-icd
    # rocmPackages.clr

    zoxide
    eza

    polybarFull

    tree
    chromium
    zathura
    mupdf

    feh

    # For neovim:

    # LSPs
    lua-language-server
    stylua
    lua
    lua52Packages.tiktoken_core
    lynx

    ### Replaced by nixd
    # nil
    nixd
    nixfmt-rfc-style
    # HACK: Only until https://github.com/neovim/neovim/pull/29601
    # is merged
    # alejandra
    # nixfmt-rfc-style
    # fsautocomplete

    # For copilot
    luajitPackages.tiktoken_core

    ### To fix haskell-lsp for xmonad
    (haskellPackages.ghcWithPackages (
      hpkgs: with hpkgs; [
        # xmobar
        xmonad
        xmonad-contrib
        # haskell-language-server
        # fast-tags
        # hoogle
        # haskell-debug-adapter
        # fourmolu
      ]
    ))
    haskellPackages.fourmolu
    haskellPackages.hoogle
    haskellPackages.haskell-language-server

    # ccls
    clang-tools_19 # clangd + clang-format

    # (python3.withPackages (
    (python3.withPackages (
      p: with p; [
        # select Python packages here
        # pandas
        # requests
        # torch
        # torchvision
        numpy
        # scikit-learn
        matplotlib
        ipython
        # sklearn-deap

        # stablePkgs.aocd
        # lark
        pyparsing
        pytest
        catppuccin
        ### LSP-stuff:
        # python-lsp-server
        # rope
        # pyflakes
        # mccabe
        # pycodestyle
        # # pydocstyle
        # yapf
        # flake8
        # pylint
      ]
    ))
    ruff # Also enabled above
    pyright

    tree-sitter
    ### FOR GITHUB PLUGIN BELOW! nodejs
    nodejs

    ### Til fsharp
    mono
    pkg-config

    # Til futhark
    jemalloc
    numactl

    vscode
    imagemagick

    # PDF med form-filling
    masterpdfeditor

    clang

    vlc

    mpv-unwrapped

    android-studio
    inkscape

    # Zen browser

    inputs.zen-browser.packages."${system}".twilight
    # inputs.zen-browser.packages.${pkgs.system}.default

    # csharp lsp
    # omnisharp-roslyn
    # mono
    # roslyn-ls
    # msbuild

    # csharpier

    ltex-ls

    dunst
    libnotify

    direnv

    bash-language-server

    nix-prefetch
    nix-prefetch-git
    nix-prefetch-github

    figma-linux

    obsidian

    betterlockscreen
  ];

}
