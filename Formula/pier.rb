# typed: false
# frozen_string_literal: true

class Pier < Formula
  desc "Clean .dock domains for Docker containers and local processes"
  homepage "https://github.com/eshe-huli/pier"
  url "https://github.com/eshe-huli/pier/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9927896769cefafdde61b0cabd570df52eb5275a5f04973fe3d06e75e7870a5f"
  license "MIT"
  head "https://github.com/eshe-huli/pier.git", branch: "main"

  depends_on "go" => :build
  depends_on "dnsmasq"
  depends_on "nginx"

  def install
    ldflags = "-X github.com/eshe-huli/pier/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/pier"
  end

  def post_install
    ohai "Run 'pier init' to complete setup (configures dnsmasq, nginx, Traefik)"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pier version")
  end
end
