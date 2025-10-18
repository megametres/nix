{}:{
  # Replace every occurence of $${themeVariable} in the input file
  replaceThemeVariables = x : let
    themeVariables = {
        primaryColor1 = "00022b";
        primaryColor2 = "010e54";
        primaryColor3 = "0855b1";
        primaryColor4 = "4fa5d8";
        primaryColor5 = "daeaf7";
        primaryBlue = "0855b1";
        primaryGreen = "00CC66";
        primaryRed = "ff3d3d";
        digitalFont = "digital-7";
        sansFont = "FantasqueMono";
        serifFont = "IosevkaTermSlabNerdFontMono";
    };
    rawFile = builtins.readFile x;
    variable_key = builtins.attrNames themeVariables;
    text_to_search = map (key: "$${${key}}") variable_key;
    text_to_replace = builtins.attrValues themeVariables;
  in
  builtins.replaceStrings text_to_search text_to_replace rawFile;
}
