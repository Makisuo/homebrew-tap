class Maple < Formula
  desc "OpenTelemetry observability platform"
  homepage "https://maple.dev"
  license "FSL-1.1-ALv2"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.22/maple-v0.0.22-aarch64-apple-darwin.tar.gz"
      sha256 "dd27e2210cbfbacab3d3bcdb0dec8a11a1b5520c4fc5a94e1e24242eaffb2799"
    end

    on_intel do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.22/maple-v0.0.22-x86_64-apple-darwin.tar.gz"
      sha256 "6164e7ae4dbcaecb7af3337d97f952a2959cdf82e9adef3a4f741fd7bb02cd04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.22/maple-v0.0.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "32aa8a7bf27c32fa4b020b7c3cf8d080a61b2d4fea2c23f4d2b2d0b702c44d65"
    end

    on_intel do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.22/maple-v0.0.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "44dae17e2fecf4e3da3cedb78cbfc09ded3c865952532a4644d6119c062ad7f0"
    end
  end

  def install
    libexec.install "maple", "libchdb.so"

    (bin/"maple").write <<~SH
      #!/bin/sh
      if [ "${1:-}" = "update" ]; then
        echo "maple was installed by Homebrew; use 'brew upgrade maple' to upgrade." >&2
        exit 1
      fi

      export MAPLE_NO_UPDATE_CHECK=1
      exec "#{libexec}/maple" "$@"
    SH
    chmod 0755, bin/"maple"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/maple --version")
    assert_match "USAGE", shell_output("#{bin}/maple --help")
    assert_match "installed by Homebrew", shell_output("#{bin}/maple update 2>&1", 1)
  end
end
