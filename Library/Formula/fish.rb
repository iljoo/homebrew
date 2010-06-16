require 'formula'

class Fish <Formula
  url 'http://downloads.sourceforge.net/project/fish/fish/1.23.1/fish-1.23.1.tar.bz2'
  homepage 'http://fishshell.org/'
  md5 'ead6b7c6cdb21f35a3d4aa1d5fa596f1'

  depends_on 'readline'
  skip_clean 'share/doc'

  def install
    system "./configure", "--prefix=#{prefix}", "--without-xsel"
    system "make install"
  end

  def caveats
    "You will need to add #{HOMEBREW_PREFIX}/bin/fish to /etc/shells\n"+
    "Run `chsh -s #{HOMEBREW_PREFIX}/bin/fish' to make fish your default shell."
  end
  
  def patches
    # Fixes sporadic freeze issue. See: http://article.gmane.org/gmane.comp.shells.fish.user/2228
    DATA
  end
end

__END__
diff --git a/proc.c b/proc.c
index 35dff1d..09d018b 100644
--- a/proc.c
+++ b/proc.c
@@ -822,8 +822,8 @@ static int select_try( job_t *j )
 		int retval;
 		struct timeval tv;
 		
-		tv.tv_sec=5;
-		tv.tv_usec=0;
+		tv.tv_sec=0;
+		tv.tv_usec=10000;
 		
 		retval =select( maxfd+1, &fds, 0, 0, &tv );
 		return retval > 0;
