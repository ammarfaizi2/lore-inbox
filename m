Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUAPXLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbUAPXLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:11:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25875 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265357AbUAPXLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:11:23 -0500
Date: Sat, 17 Jan 2004 00:13:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Maintainers update
Message-ID: <20040116231309.GA6997@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify MAINTAINERS to reflect the reality in maintainership for kbuild.
This is ack'ed with Michael Elizabeth Chastain and Kai Germaschewski.

I removed the list and web-site since they are not actively used today.

	Sam

===== MAINTAINERS 1.185 vs edited =====
--- 1.185/MAINTAINERS	Wed Dec 31 01:35:27 2003
+++ edited/MAINTAINERS	Sat Jan 17 00:00:07 2004
@@ -1143,11 +1143,11 @@
 L:	autofs@linux.kernel.org
 S:	Maintained
 
-KERNEL BUILD (Makefile, Rules.make, scripts/*)
-P:	Michael Elizabeth Chastain
-M:	mec@shout.net
-L:	kbuild-devel@lists.sourceforge.net
-W:	http://kbuild.sourceforge.net
+KERNEL BUILD (kbuild: Makefile, scripts/Makefile.*)
+P:	Kai Germaschewski
+M:	kai@germaschewski.name
+P:	Sam Ravnborg
+M:	sam@ravnborg.org
 S:	Maintained 
 
 KERNEL JANITORS
