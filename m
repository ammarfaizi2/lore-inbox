Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317075AbSEXLPi>; Fri, 24 May 2002 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSEXLPh>; Fri, 24 May 2002 07:15:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:41371 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317075AbSEXLPg>;
	Fri, 24 May 2002 07:15:36 -0400
Date: Fri, 24 May 2002 13:11:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp: making myself maintainer
Message-ID: <20020524111148.GA331@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I asked Gabor if he'd like me to maintain swsusp, and he liked that
idea [<quote>Would you please take over maintaining? I offered this in
the list a while ago anyway.</quote>]. Here's the patch, please apply.

									Pavel

--- linux-swsusp.linus/CREDITS	Mon May 13 23:27:06 2002
+++ linux-swsusp/CREDITS	Fri May 24 13:09:17 2002
@@ -1704,6 +1704,11 @@
 S: Schlehenweg 9
 S: D-91080 Uttenreuth
 S: Germany
+
+N: Gabor Kuti
+M: seasons@falcon.sch.bme.hu
+M: seasons@makosteszta.sote.hu
+D: Software suspend
 
 N: Jaroslav Kysela
 E: perex@suse.cz
--- linux-swsusp.linus/MAINTAINERS	Wed May 22 21:12:16 2002
+++ linux-swsusp/MAINTAINERS	Fri May 24 13:03:02 2002
@@ -1447,11 +1447,11 @@
 S:	Maintained
 
 SOFTWARE SUSPEND:
-P:	Gabor Kuti
-M:	seasons@falcon.sch.bme.hu
-M:	seasons@makosteszta.sote.hu
+P:	Pavel Machek
+M:	pavel@suse.cz
+M:	pavel@ucw.cz
 L:	http://lister.fornax.hu/mailman/listinfo/swsusp
-W:	http://falcon.sch.bme.hu/~seasons/linux
+W:	http://swsusp.sf.net/
 S:	Maintained
 
 SONIC NETWORK DRIVER

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
