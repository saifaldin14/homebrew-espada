# 🚚 This tap has moved

**New location:** [`Espada-Firewall/homebrew-tap`](https://github.com/Espada-Firewall/homebrew-tap)

## What to do

If you have this tap installed, switch to the new one:

```bash
brew untap saifaldin14/espada
brew install espada-firewall/tap/espada
```

Or, if you've never tapped this repo:

```bash
brew install espada-firewall/tap/espada
```

## Why

The tap originally lived under a personal GitHub account
(`saifaldin14`). It now lives under the
[`Espada-Firewall`](https://github.com/Espada-Firewall) organisation,
matching the convention used by HashiCorp, Cloudflare, Bun, Fly.io, and
every other serious tool that ships via a custom tap. The new install
command is shorter and reads correctly as a product, not a personal
project.

## Same artefact

The `v2026.1.48` tarball mirrored to the new tap is **bit-for-bit
identical** (sha256 `9254bb5bd5347744c4774b6f7c66ffe9952f02edf17ef9c10db4e00021855fec`)
to the one previously published here. Nothing about the binary changed.

## Status

This repo is **archived** — read-only, no new releases. The formula
under `Formula/espada.rb` still resolves for anyone who already has the
tap, but it points at this repo's old releases and will not receive
future updates. Switch to the new tap to get future versions.

---

For all docs, install instructions, and source, see
<https://espadafirewall.com> and
<https://github.com/Espada-Firewall/homebrew-tap>.
