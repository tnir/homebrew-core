class Libgphoto2 < Formula
  desc "Gphoto2 digital camera library"
  homepage "http://www.gphoto.org/proj/libgphoto2/"
  url "https://downloads.sourceforge.net/project/gphoto/libgphoto/2.5.27/libgphoto2-2.5.27.tar.bz2"
  sha256 "f8b85478c44948a0b0b52c4d4dfda2de1d7bcb7b262c76bd1ae306d9c63240d7"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/libgphoto2[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "2215d38a580f2d8e80bbcdfc6eb0a6b84db905e33db309fc8225fd73cf2cf480"
    sha256 big_sur:       "d622d90aec3ddb4e168eda447ff0841c318b701710906290636ba24d4b9d7b60"
    sha256 catalina:      "9ab56abc466d07fdb2d16aced13ae7afffb9e71642b8c86a0b1610304e34baba"
    sha256 mojave:        "434336b976e6c930255891e9d478fec925c484f50fdf153dca262a9184b6874b"
    sha256 high_sierra:   "918032eba6577fda5b956841d50abd91c5272a0d1b69d21f3ac9f40eb24027af"
  end

  head do
    url "https://github.com/gphoto/libgphoto2.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gd"
  depends_on "libtool"
  depends_on "libusb-compat"

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gphoto2/gphoto2-camera.h>
      int main(void) {
        Camera *camera;
        return gp_camera_new(&camera);
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lgphoto2", "-o", "test"
    system "./test"
  end
end
