{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.churri;
  churri-pkg = pkgs.callPackage ./default.nix { };

  # Taken from immich
  commonServiceConfig = {
    Type = "simple";
    Restart = "on-failure";
    RestartSec = 3;

    # Hardening
    CapabilityBoundingSet = "";
    NoNewPrivileges = true;
    PrivateUsers = true;
    PrivateTmp = true;
    PrivateDevices = true;
    PrivateMounts = true;
    ProtectClock = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelLogs = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    RestrictAddressFamilies = [
      "AF_INET"
      "AF_INET6"
      "AF_UNIX"
    ];
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
  };
in
{
  options.services.churri = {
    enable = lib.mkEnableOption "churri";
    port = lib.mkOption {
      type = lib.types.int;
      default = 2001;
      description = "Port to listen on";
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "localhost";
    };

    origin = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      example = "https://my.site";
      default = null;
    };

    targetDate = lib.mkOption {
      description = ''
        Date to countdown to, can be format YYYY-MM-DD:HH:MM:SS (or anything that is accepted by 
        [Javascript's `Date` constructor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date);
      '';
      type = lib.types.str;
      example = "2025-05-10:18:35:00+01:00";
    };

    node-package = lib.mkPackageOption pkgs "node" { };
  };

  config.systemd.services.churri = lib.mkIf cfg.enable {
    description = "Countdown timer";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = commonServiceConfig // {
      ExecStart = "${pkgs.nodejs}/bin/node ${churri-pkg}/build";
      StateDirectory = "churri";
      SyslogIdentifier = "churri";
      RuntimeDirectory = "churri";
    };

    environment = {
      "PORT" = "${toString cfg.port}";
      "HOST" = cfg.host;
      "ORIGIN" = lib.mkIf (cfg.origin != null) cfg.origin;
      "TARGET_DATE" = cfg.targetDate;
    };
  };
}
