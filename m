Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbULTB5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbULTB5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULTB4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:56:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261389AbULTBxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:53:46 -0500
Date: Mon, 20 Dec 2004 02:53:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jonathan@buzzard.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove subscribers-only tlinux-users address (fwd)
Message-ID: <20041220015341.GR21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies against 2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 6 Dec 2004 19:42:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jonathan@buzzard.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove subscribers-only tlinux-users address

It's generally agreed that subscribers-only mailing lists shouldn't be 
listed in MAINTAINERS (since it's impossible to send a simple Cc to such 
a list).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/MAINTAINERS.old	2004-12-06 19:40:38.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/MAINTAINERS	2004-12-06 19:40:54.000000000 +0100
@@ -2188,7 +2188,6 @@
 TOSHIBA SMM DRIVER
 P:	Jonathan Buzzard
 M:	jonathan@buzzard.org.uk
-L:	tlinux-users@tce.toshiba-dme.co.jp
 W:	http://www.buzzard.org.uk/toshiba/
 S:	Maintained
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

