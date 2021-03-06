require "language/haskell"

class Texmath < Formula
  include Language::Haskell::Cabal

  desc "Haskell library for converting LaTeX math to MathML"
  homepage "https://johnmacfarlane.net/texmath.html"
  url "https://hackage.haskell.org/package/texmath-0.12/texmath-0.12.tar.gz"
  sha256 "5e1915a87774428733575cd47ce1f4050a70ab30c8518238e320036e877a8125"

  bottle do
    cellar :any_skip_relocation
    sha256 "03203284dd76815b6ab59b24ae4730db26ca4ad37cceb09b6d8b92b598bfd1eb" => :catalina
    sha256 "eb7534eeb2e36f93cc7262e446e908918b87a0aeedac653a7d32212a964462b2" => :mojave
    sha256 "f2054064d399c56953d8cadedf9a23d77d251c5229279bbec929816acbfd6cc2" => :high_sierra
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package "--enable-tests", :flags => ["executable"] do
      system "cabal", "test"
    end
  end

  test do
    assert_match "<mn>2</mn>", pipe_output(bin/"texmath", "a^2 + b^2 = c^2")
  end
end
