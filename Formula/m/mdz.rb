class Mdz < Formula
  desc "CLI for the mdz ledger Open Source"
  homepage "https://github.com/LerianStudio/midaz"
  url "https://github.com/LerianStudio/midaz/archive/refs/tags/v1.41.0.tar.gz"
  sha256 "80e81b373625a4449da7f241e6c40ad950af31f3eb18585bd071b311e2c16a87"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60da77d3e4e825aa093e7388456c421f68c0dd31b3045b849d02385c830d4d3f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "60da77d3e4e825aa093e7388456c421f68c0dd31b3045b849d02385c830d4d3f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "60da77d3e4e825aa093e7388456c421f68c0dd31b3045b849d02385c830d4d3f"
    sha256 cellar: :any_skip_relocation, sonoma:        "b1d373883990953800e9114a167a5e8f55f5115f6bec960061ec279c167fecf1"
    sha256 cellar: :any_skip_relocation, ventura:       "b1d373883990953800e9114a167a5e8f55f5115f6bec960061ec279c167fecf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e332d6dca7120ac0bb56be02e9fc95e005f9af97f764946a7d788c81481ec0bb"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/LerianStudio/midaz/components/mdz/pkg/environment.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./components/mdz"
  end

  test do
    assert_match "Mdz CLI #{version}", shell_output("#{bin}/mdz --version")

    client_id = "9670e0ca55a29a466d31"
    client_secret = "dd03f916cacf4a98c6a413d9c38ba102dce436a9"
    url_api_auth = "http://127.0.0.1:8080"
    url_api_ledger = "http://127.0.0.1:3000"

    output = shell_output("#{bin}/mdz configure --client-id #{client_id} " \
                          "--client-secret #{client_secret} --url-api-auth #{url_api_auth} " \
                          "--url-api-ledger #{url_api_ledger}")

    assert_match "client-id:       9670e0ca55a29a466d31", output
    assert_match "client-secret:   dd03f916cacf4a98c6a413d9c38ba102dce436a9", output
    assert_match "url-api-auth:    http://127.0.0.1:8080", output
    assert_match "url-api-ledger:  http://127.0.0.1:3000", output
  end
end
