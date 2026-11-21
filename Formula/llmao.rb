class Llmao < Formula
  desc "Launch a coding agent for natural-language requests typed into your shell"
  homepage "https://github.com/mquan/llmao"
  url "https://github.com/mquan/llmao/releases/download/v0.4.0/llmao-v0.4.0.tar.gz"
  version "0.4.0"
  sha256 "6eef87523cca096b3b257573af6814aa9253197c1e797de4c519a1f4fcbb3a97"
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
