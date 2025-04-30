# Hardware-related configurations
{ config, lib, pkgs, ... }:

{
  # --- Hardware Settings --- 
  # Apply CPU microcode updates.
  hardware.cpu.intel.updateMicrocode = true;

  hardware = {
    # Enable OpenGL support.
    graphics = {
      enable = true;
    };
    # Enable Bluetooth support.
    /*
    bluetooth = {
      enable = true;
      powerOnBoot = true; # Turn on Bluetooth automatically.
    };
    */
    # Use PipeWire for audio, so disable PulseAudio.
    pulseaudio.enable = false;
  };

  # --- Audio Setup --- 
  # Enable PipeWire for managing audio streams.
  services.pipewire = {
    enable = true;
    alsa.enable = true; # ALSA compatibility.
    alsa.support32Bit = true; # For 32-bit ALSA apps.
    pulse.enable = true; # PulseAudio compatibility layer.
    jack.enable = true; # JACK compatibility.
    wireplumber.enable = true; # Session manager for PipeWire.
  };

  # --- Power Management ---
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand"; # Options: ondemand, performance, powersave
  };

  # --- Console Setup --- 
  # Settings for the virtual console (TTY).
  console = {
    earlySetup = true;
    font = "sun12x22"; # A readable font for the TTY.
    useXkbConfig = true; # Use X11 keymap settings in TTY.
  };
} 