Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbSLRJCH>; Wed, 18 Dec 2002 04:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSLRJCH>; Wed, 18 Dec 2002 04:02:07 -0500
Received: from dp.samba.org ([66.70.73.150]:4805 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267214AbSLRJCC>;
	Wed, 18 Dec 2002 04:02:02 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Update MAINTAINERS for modules
Date: Wed, 18 Dec 2002 19:58:13 +1100
Message-Id: <20021218091001.D6CF62C076@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since it looks like Linus isn't going to rip the code out...

Cheers,
Rusty.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/MAINTAINERS working-2.5.52-procmodules/MAINTAINERS
--- linux-2.5.52/MAINTAINERS	Tue Dec 10 15:56:46 2002
+++ working-2.5.52-procmodules/MAINTAINERS	Wed Dec 18 19:54:06 2002
@@ -1124,6 +1124,12 @@ W:	http://www.acc.umu.se/~mcalinux/
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MODULE SUPPORT
+P:	Rusty Russell
+M:	rusty@rustcorp.com.au
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
 P:	Stelian Pop
 M:	stelian@popies.net

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
