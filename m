Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316251AbSEZSdW>; Sun, 26 May 2002 14:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEZSdV>; Sun, 26 May 2002 14:33:21 -0400
Received: from [195.39.17.254] ([195.39.17.254]:63387 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316251AbSEZSdU>;
	Sun, 26 May 2002 14:33:20 -0400
Date: Sun, 26 May 2002 20:31:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: trivial: reiserfs whitespace
Message-ID: <20020526183128.GA11385@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kill space at EOLN.

									Pavel

--- clean/fs/reiserfs/journal.c	Sun May 26 19:32:02 2002
+++ linux-swsusp/fs/reiserfs/journal.c	Sun May 26 19:52:04 2002
@@ -57,7 +57,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/suspend.h> 
+#include <linux/suspend.h>
 #include <linux/buffer_head.h>
 
 /* the number of mounted filesystems.  This is used to decide when to



-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
