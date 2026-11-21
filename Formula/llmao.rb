class Llmao < Formula
  desc "Launch a coding agent for natural-language requests typed into your shell"
  homepage "https://github.com/mquan/llmao"
  url "https://github.com/mquan/llmao/releases/download/v0.3.0/llmao-v0.3.0.tar.gz"
  version "0.3.0"
  sha256 "d7f77b3a1055dd67acccd18335ac74a6a54af7b227f185bb884892f25b850992"

  depends_on :macos

  def install
    (share/"llmao").install "llmao.plugin.zsh", "llmao.plugin.bash",
                           "llmao.plugin.fish", "llmao-bridge.zsh", "llmao"
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
