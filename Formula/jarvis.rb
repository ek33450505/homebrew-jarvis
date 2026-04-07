class Jarvis < Formula
  desc "JARVIS Personal Assistant — 8 pa-* Claude Code agents with launchd scheduling"
  homepage "https://github.com/ek33450505/jarvis"
  url "https://github.com/ek33450505/jarvis/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "PLACEHOLDER"  # Update after tagging v0.1.0 and computing: shasum -a 256 v0.1.0.tar.gz
  license "MIT"

  def install
    libexec.install Dir["agents/*"]
    libexec.install Dir["scripts/*"]
    libexec.install Dir["launchd/*"]
    libexec.install Dir["config/*"]
    (libexec/"VERSION").write(File.read("VERSION"))
    prefix.install "VERSION"
    prefix.install "install.sh"
    prefix.install "uninstall.sh"
  end

  def caveats
    <<~EOS
      JARVIS files are staged at #{libexec}.
      To complete installation (copies agents, loads launchd plists):
        bash #{prefix}/install.sh

      To uninstall:
        bash #{prefix}/uninstall.sh

      After installing, configure:
        cp ~/.claude/config/jarvis.conf.example ~/.claude/config/jarvis.conf
        # Edit jarvis.conf with your NWS coordinates and Jira URL

      Manual MCP setup required for:
        - Google Calendar (pa-briefing, pa-calendar)
        - Gmail (pa-triage)
      Configure these in Claude Desktop settings.

      Obsidian Git plugin recommended for pa-briefing meeting notes.
      Zoe voice (macOS System Preferences > Accessibility > Spoken Content) used by pa-briefing for audio readout.
    EOS
  end

  test do
    assert_predicate prefix/"install.sh", :exist?
    assert_predicate prefix/"uninstall.sh", :exist?
  end
end
