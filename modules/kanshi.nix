{ ...
}: {
  services.kanshi = {
    enable = true;
    profiles = {
      sucellus = {
        outputs = [
          {
            criteria = "Chimei Innolux Corporation 0x1301 Unknown";
            scale = 1.25;
          }
        ];
      };
      helvetios = {
        outputs = [
          {
            criteria = "Sharp Corporation 0x14FA Unknown";
            scale = 2.0;
          }
        ];
      };
      quoth = {
        outputs = [
          {
            criteria = "LG Electronics LG Ultra HD 0x00002FE9";
            scale = 1.5;
            position = "0,0";
          }
          {
            criteria = "HP Inc. HP Z27q G3 CN4112035R";
            scale = 1.0;
            position = "0,1440";
          }
        ];
      };
    };
  };
}
