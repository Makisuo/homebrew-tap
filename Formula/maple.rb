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
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.13/maple-v0.0.13-aarch64-apple-darwin.tar.gz"
      sha256 "c2fefe8b610a32e82141c6c82a5715877459b6c036b3ea39cb79b81e2fda844e"
    end

    on_intel do
      odie "Maple does not publish an Intel macOS Homebrew bundle yet."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.13/maple-v0.0.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "07c8f5291223faf7f00a54074d44ee2741c05da8cecd08a8668fb2c7d3d35bb1"
    end

    on_intel do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.13/maple-v0.0.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57265ed3a28e13839167d3f16362245b7b6712b226323d70056fa0299043a556"
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
