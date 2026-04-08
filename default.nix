{
  lib,
  self,
  buildGoModule,
  git,
  icu,
  ...
}:
buildGoModule {
  pname = "beads";
  version = "1.0.0";

  src = self;

  # Point to the main Go package
  subPackages = [ "cmd/bd" ];
  doCheck = false;

  # Go module dependencies hash - if build fails with hash mismatch, update with the "got:" value
  vendorHash = "sha256-UCODmlavmZc2/4ltA2g71UvjjNLxEG+g82IFUjNtpdI=";
  # Due to https://github.com/dolthub/go-icu-regex, which requires
  # separate install of icu headers and library.
  env.CGO_CPPFLAGS="-I${icu.dev}/include";
  env.CGO_LDFLAGS="-L${icu}/lib";

  # Git is required for tests
  nativeBuildInputs = [ git ];

  meta = with lib; {
    description = "beads (bd) - An issue tracker designed for AI-supervised coding workflows";
    homepage = "https://github.com/gastownhall/beads";
    license = licenses.mit;
    mainProgram = "bd";
    maintainers = [ ];
  };
}
