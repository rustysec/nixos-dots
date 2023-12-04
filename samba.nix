{ ... }:
{

  networking.firewall = {
    allowedTCPPorts = [
      5357 # wsdd
    ];
    allowedUDPPorts = [
      3702 # wsdd
    ];
    enable = true;
    allowPing = true;
  };

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  services.samba.openFirewall = true;
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = quoth
      netbios name = quoth
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.122. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = { };
      private = { };
      homes = {
        description = "Home Folders";
        read-only = "no";
        public = "no";
        browsable = "yes";
      };
    };
  };
}
