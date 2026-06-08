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
      url "https://github.com/Makisuo/maple/releases/download/v0.0.11/maple-v0.0.11-aarch64-apple-darwin.tar.gz"
      sha256 "d3accb88502c91c64b4876766e34de448a1425ee869233ea46dd147a1e9f7377"
    end

    on_intel do
      odie "Maple does not publish an Intel macOS Homebrew bundle yet."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Makisuo/maple/releases/download/v0.0.11/maple-v0.0.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4598d9fd53894ccaf279a27088bfa7e7d25c4034653edbc6a42c81e8093e7e20"
    end

    on_intel do
      url "https://github.com/Makisuo/maple/releases/download/v0.0.11/maple-v0.0.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9decdd2c03cf02e7a9ee9722f4d5d17dd93a9d57a97c5fe9464030a36e8f336e"
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
