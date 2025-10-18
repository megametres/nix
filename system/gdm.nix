{ pkgs, ... }:

{
  services.displayManager.gdm = {
  enable = true;
    settings = {
      "org/gnome/login-screen" = {
        disable-restart-buttons = false;
      };
    };
  };

  systemd.tmpfiles.rules = let
    monitorsXml = pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>3</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>SAM</vendor>
                <product>SAMSUNG</product>
                <serial>0x01000e00</serial>
              </monitorspec>
              <mode>
                <width>3840</width>
                <height>2160</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    '';
  in [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsXml}"
  ];
}
