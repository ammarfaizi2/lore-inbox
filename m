Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVAPHeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVAPHeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAPHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:34:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59661 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262391AbVAPHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:34:17 -0500
Date: Sun, 16 Jan 2005 08:34:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [patch] update email address of Andrea Arcangeli (fwd)
Message-ID: <20050116073409.GT4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch below (already ACK'ed by Andrea Arcangeli) still 
applies against 2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 11 Dec 2004 20:01:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [patch] update email address of Andrea Arcangeli

Hi Andrea,

the patch below (applies against both 2.4 and 2.6) replaces your 
bouncing andrea@e-mind.com email address in the MAINTAINERS entry for 
parallel port support with andrea@suse.de .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/MAINTAINERS.old	2004-12-11 19:57:52.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/MAINTAINERS	2004-12-11 19:58:10.000000000 +0100
@@ -1694,3 +1694,3 @@
 P:	Andrea Arcangeli
-M:	andrea@e-mind.com
+M:	andrea@suse.de
 L:	linux-parport@lists.infradead.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

