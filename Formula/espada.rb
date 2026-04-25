# typed: false
# frozen_string_literal: true

# Espada — self-hosted infrastructure control plane with conversational AI.
#
# This formula installs a pre-built, platform-specific tarball produced by
# `.github/workflows/release.yml`. No network access is required during
# `brew install`; the tarball already contains a flat production
# `node_modules/` tree and the compiled `dist/` output.
#
# The CLI requires Node.js >= 22.12, which we declare as a hard runtime
# dependency. The shim in `bin/espada` is an exec wrapper around
# `node libexec/espada-<version>/espada.mjs`.
#
# Update procedure (when you cut a new release):
#   1. Push a `vX.Y.Z` tag — release workflow attaches tarballs to the GH release.
#   2. Run `scripts/update-formula.mjs vX.Y.Z` to refresh `version`, urls,
#      and sha256 fields in this file.
#   3. Commit and push to saifaldin14/homebrew-espada.

class Espada < Formula
  desc "Self-hosted infrastructure control plane with conversational AI"
  homepage "https://github.com/saifaldin14/Espada-Auto"
  version "2026.1.27"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/saifaldin14/Espada-Auto/releases/download/v#{version}/espada-#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/saifaldin14/Espada-Auto/releases/download/v#{version}/espada-#{version}-darwin-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/saifaldin14/Espada-Auto/releases/download/v#{version}/espada-#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/saifaldin14/Espada-Auto/releases/download/v#{version}/espada-#{version}-linux-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  depends_on "node@22"

  def install
    libexec.install Dir["*"]
    (bin/"espada").write <<~SH
      #!/bin/bash
      exec "#{Formula["node@22"].opt_bin}/node" "#{libexec}/espada.mjs" "$@"
    SH
    chmod 0755, bin/"espada"
  end

  def caveats
    <<~EOS
      Espada stores its config under ~/.espada/ and its workspace under
      ~/espada by default. Run the first-time wizard with:

          espada setup

      To start a local Gateway in the dev profile (recommended for first run):

          espada --dev gateway --force

      Documentation: https://docs.espada.dev
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/espada --version"))
    assert_match("Usage: espada", shell_output("#{bin}/espada --help"))
  end
end
