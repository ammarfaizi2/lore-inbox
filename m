Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUIRWVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUIRWVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269650AbUIRWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:21:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:15588 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268216AbUIRWV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:21:29 -0400
Date: Sun, 19 Sep 2004 00:19:28 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: parisc-linux@parisc-linux.org
Subject: [PATCH] fix syntax error in asm-parisc/som.h
Message-ID: <20040918221928.GA28627@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The comment is not closed.
The file is also not used anywhere, maybe it can be removed.

Signed-off-by: Olaf Hering <olh@suse.de>


diff -purN linux-2.6.8/include/asm-parisc/som.h linux-2.6.8.xxx/include/asm-parisc/som.h
--- linux-2.6.8/include/asm-parisc/som.h	2004-08-14 07:36:58.000000000 +0200
+++ linux-2.6.8.xxx/include/asm-parisc/som.h	2004-09-19 00:15:16.896999616 +0200
@@ -5,4 +5,4 @@
 #include <linux/som.h>
 
 
-#endif /* _ASM_PARISC_SOM_H
+#endif /* _ASM_PARISC_SOM_H */

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
