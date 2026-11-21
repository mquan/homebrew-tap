class Llmao < Formula
  desc "Launch a coding agent for natural-language requests typed into zsh"
  homepage "https://github.com/mquan/llmao"
  url "https://github.com/mquan/llmao/releases/download/v0.1.0/llmao-v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "d464eadacdeb2868fe62878435efd8808de4355a7fb75fa91b1d0400dc195c19"

  depends_on :macos

  def install
    (share/"llmao").install "llmao.plugin.zsh"
  end

  def caveats
    <<~EOS
      Add this to your .zshrc after any existing command-not-found integration:
        source "#{opt_share}/llmao/llmao.plugin.zsh"
    EOS
  end

  test do
    system "/bin/zsh", "-n", share/"llmao/llmao.plugin.zsh"
    output = shell_output("/bin/zsh -dfc 'source #{share}/llmao/llmao.plugin.zsh; " \
                          "_llmao_classify 2 gti status git; print -r -- \"$reply[*]\"'")
    assert_equal "TYPO git", output.strip
  end
end
