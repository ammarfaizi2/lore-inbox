Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWACX0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWACX0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWACX0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:26:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54491 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965019AbWACX0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:51 -0500
To: torvalds@osdl.org
Subject: [PATCH 05/41] m68k: dumb typo in atyfb
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYI-0003LN-Fc@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:26:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133440411 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/aty/atyfb_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f913080462caf7bcdb6607b48d0a7d66dbd53e4c
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 08edbfc..a2fdcd2 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3472,7 +3472,7 @@ err_release_mem:
 
 static int __devinit atyfb_atari_probe(void)
 {
-	struct aty_par *par;
+	struct atyfb_par *par;
 	struct fb_info *info;
 	int m64_num;
 	u32 clock_r;
-- 
0.99.9.GIT

