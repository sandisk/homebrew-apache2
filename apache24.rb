require 'formula'

class Apache24 < Formula
  homepage 'https://httpd.apache.org/'
  url 'http://mirror.cc.columbia.edu/pub/software/apache/httpd/httpd-2.4.9.tar.gz'
  sha1 '50496e51605a3d852c183a7c667c25bcc7ee658d'

  depends_on 'autoconf'
  depends_on 'libtool'
  depends_on 'pcre'
  
  skip_clean :la

  def install

    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--localstatedir=#{var}/apache2",
      "--sysconfdir=#{etc}/apache2",
      "--enable-layout=GNU",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-mpm=prefork",
      "--enable-mods-shared=all",
      "--enable-load-all-modules"
    ]

    system "./configure", "LTFLAGS=--tag=cc", *args
    system "make"
    system "make install"
    
    (var/'apache2/log').mkpath
    (var/'apache2/run').mkpath

  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_prefix}/sbin/apachectl</string>
        <string>start</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
    EOS
  end
end
