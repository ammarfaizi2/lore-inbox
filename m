Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbULKTBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbULKTBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULKTBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:01:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261993AbULKTBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:01:45 -0500
Date: Sat, 11 Dec 2004 20:01:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [patch] update email address of Andrea Arcangeli
Message-ID: <20041211190134.GZ22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

