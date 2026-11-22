class Llmao < Formula
  desc "Launch a coding agent for natural-language requests typed into your shell"
  homepage "https://github.com/mquan/llmao"
  url "https://github.com/mquan/llmao/releases/download/v0.5.0/llmao-v0.5.0.tar.gz"
  version "0.5.0"
  sha256 "909141f4979abc2f3e2fc80738a9cdd18c27054b9c85790067747d0dd221c9ea"
  license "MIT"

  depends_on :macos

  def install
    (share/"llmao").install "llmao.plugin.zsh", "llmao.plugin.bash",
                           "llmao.plugin.fish", "llmao-bridge.zsh", "llmao", "LICENSE"
    bin.install_symlink share/"llmao"/"llmao"
  end

  def caveats
    <<~EOS
      Add the line for your shell after any existing command-not-found integration.
      zsh (~/.zshrc)
        source "#{opt_share}/llmao/llmao.plugin.zsh"
      Bash 4+ (~/.bashrc or your Bash login profile)
        source "#{opt_share}/llmao/llmao.plugin.bash"
      Fish 3.6+ (~/.config/fish/config.fish)
        source "#{opt_share}/llmao/llmao.plugin.fish"
    EOS
  end

  test do
    system "/bin/zsh", "-n", share/"llmao/llmao.plugin.zsh"
    output = shell_output("/bin/zsh -dfc 'source #{share}/llmao/llmao.plugin.zsh; " \
                          "_llmao_classify gti git; print -r -- \"$reply[*]\"'")
    assert_equal "TYPO git", output.strip
  end
end
