# Homebrew Tap for Maple

Install Maple with Homebrew:

```sh
brew install Makisuo/tap/maple
```

Upgrade Maple with Homebrew:

```sh
brew upgrade maple
```

Uninstall Maple:

```sh
brew uninstall maple
```

This tap packages Maple's GitHub release bundles. Each bundle contains the
`maple` executable and its sibling `libchdb.so`; the formula keeps both files
together in `libexec` and exposes a wrapper at `bin/maple`.

`maple update` is intentionally blocked for Homebrew installs. Use
`brew upgrade maple` so Homebrew owns installed versions and receipts.

## Platform Support

- macOS Apple Silicon: supported
- Linux x86_64: supported
- Linux arm64: supported
- macOS Intel: not available until Maple publishes an
  `x86_64-apple-darwin` release bundle

## Release Bumps

After Maple publishes a release, update `Formula/maple.rb`:

1. Set `version` to the release without the leading `v`.
2. Update the platform release URLs if the asset names changed.
3. Replace each `sha256` with the matching `.tar.gz.sha256` value from the
   GitHub release.
4. Run:

```sh
brew tap Makisuo/tap
brew audit --formula maple
brew reinstall maple
brew test maple
```
