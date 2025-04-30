{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.fox7fog = {
    xdg.configFile = {
      "hypr/wofi/config" = {
        text = ''
          show=drun
          width=500
          height=400
          always_parse_args=true
          show_all=true
          print_command=true
          insensitive=true
          prompt=Apps
          matching=contains
          sort_order=default
          gtk_dark=true
          allow_images=true
          image_size=24
          cache_file=/dev/null
          term=alacritty
          columns=1
        '';
      };

      "hypr/wofi/style.css" = {
        text = ''
          window {
            margin: 0px;
            border: 2px solid #cba6f7;
            border-radius: 15px;
            background-color: #1e1e2e;
            font-family: "JetBrainsMono Nerd Font";
            font-size: 13px;
          }

          #input {
            padding: 4px;
            margin: 4px;
            padding-left: 20px;
            border: none;
            color: #cdd6f4;
            font-weight: bold;
            background-color: #1e1e2e;
            background: unset;
            outline: none;
            border-radius: 15px;
            margin: 10px;
            margin-bottom: 2px;
          }
          
          #input:focus {
            border: 0px solid #1e1e2e;
            margin-bottom: 0px;
          }

          #inner-box {
            margin: 4px;
            border: 10px solid #1e1e2e;
            color: #cdd6f4;
            font-weight: bold;
            background-color: #1e1e2e;
          }

          #outer-box {
            margin: 0px;
            border: none;
            border-radius: 15px;
            background-color: #1e1e2e;
          }

          #scroll {
            margin-top: 5px;
            border: none;
            border-radius: 15px;
            margin-bottom: 5px;
          }

          #img:selected {
            background-color: #89b4fa;
            border-radius: 15px;
          }

          #text:selected {
            color: #cdd6f4;
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background-color: #89b4fa;
          }

          #entry {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background-color: transparent;
          }

          #entry:selected {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background-color: #89b4fa;
          }
        '';
      };
    };
  };
} 