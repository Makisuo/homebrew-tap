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
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.19/maple-v0.0.19-aarch64-apple-darwin.tar.gz"
      sha256 "823ad037adfabd39c939b4221466b28d857c68f4bf39f5b63f7331d9c9ca3439"
    end

    on_intel do
      odie "Maple does not publish an Intel macOS Homebrew bundle yet."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.19/maple-v0.0.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f1ccc30373e3551c0f6e1f72af7b25c5086a330dcc5cac7a147833f5285c405d"
    end

    on_intel do
      url "https://github.com/MapleTechLabs/maple/releases/download/v0.0.19/maple-v0.0.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e56585ad90acfb606b7f72de7dd09521cb6495f88a3e378c9103cc7af3606c56"
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
