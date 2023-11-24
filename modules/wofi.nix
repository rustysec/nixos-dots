{ ...
}:
{
  programs.wofi.enable = true;
  programs.wofi.settings = {
    insensitive = true;
    width = 800;
    height = 400;
    mode = "drun,run";
  };
  programs.wofi.style = ''
    * {
        font-family: monospace;
    }

    window {
        margin: 5px;
        border: 0px solid white;
        background-color: rgba(48, 98, 148, 1.0);
    }

    #input {
        margin: 5px;
        border-radius: 0px;
        border: none;
        border-bottom: 0px solid black;
        background-color: #1A1C1E;
        color: white;
    }

    #inner-box {
        margin: 5px;
        background-color: #1A1C1E;
    }

    #outer-box {
        margin: 5px;
        padding:20px;
        background-color: #1A1C1E;
    }

    #scroll { }

    #text {
        margin: 5px;
        color: white;
    }

    #entry:selected {
        background-color: #151718;
    }

    #text:selected {
        text-decoration-color: white;
    }
  '';
}
