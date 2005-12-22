Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVLVEtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVLVEtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVLVEtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:49:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21968 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965049AbVLVEta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:30 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 05/36] m68k: dumb typo in atyfb
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOP-0004qH-Fd@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133440411 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/video/aty/atyfb_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ecaf29aea7286901cd2c2f14c30f84cdd5ad966a
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

