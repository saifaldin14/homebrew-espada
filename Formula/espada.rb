# typed: false
# frozen_string_literal: true

# Espada — self-hosted infrastructure control plane with conversational AI.
#
# This formula installs a pre-built, platform-specific tarball published to
# this tap's GitHub releases. The tarball is fully self-contained — it ships
# with `node_modules/` already vendored — so `brew install` runs no
# `pnpm install` or postinstall scripts.
#
# Update procedure when you cut a new release:
#   1. Build a tarball locally on a darwin/arm64 machine:
#        node scripts/build-release-tarball.mjs
#   2. Tag this tap repo `vX.Y.Z` and attach the tarball + .sha256 to the
#      GitHub release.
#   3. Bump `version` and the `sha256` below; commit + push.

class Espada < Formula
  desc "Self-hosted infrastructure control plane with conversational AI"
  homepage "https://github.com/saifaldin14/homebrew-espada"
  version "2026.1.46"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/saifaldin14/homebrew-espada/releases/download/v#{version}/espada-#{version}-darwin-arm64.tar.gz"
      sha256 "1fae98e85f482ac38e6e06ca7aa27bfa467d650ce9cb3d0e5855a9d9d93aaddc"
    end
  end

  depends_on "node@22"
  depends_on arch: :arm64
  depends_on :macos

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
      Espada stores its config under ~/.espada and its workspace under ~/espada
      by default. Run the first-time wizard with:

          espada setup

      To start a local Gateway in dev mode:

          espada --dev gateway --force

      Documentation: https://github.com/saifaldin14/homebrew-espada
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/espada --version"))
  end
end
