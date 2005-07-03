Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVGCVCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVGCVCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVGCVCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:02:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52913 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261540AbVGCVBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:01:53 -0400
Date: Sun, 3 Jul 2005 22:29:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] One more system where video works with S3
Message-ID: <20050703202912.GA24404@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more system where video works with S3.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 4b632470fc69174a9732c19419be5d1fc2cdeb0e
tree 008b3b066671d1d30257a6a52606268884731985
parent bf6565cc60d70997000b3ee19f0330fbde21e382
author <pavel@amd.(none)> Sun, 03 Jul 2005 22:28:28 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 22:28:28 +0200

 Documentation/power/video.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -117,6 +117,7 @@ IBM Thinkpad X40 Type 2371-7JG  s3_bios,
 Medion MD4220			??? (*)
 Samsung P35			vbetool needed (6)
 Sharp PC-AR10 (ATI rage)	none (1)
+Sony Vaio PCG-C1VRX/K		s3_bios (2)
 Sony Vaio PCG-F403		??? (*)
 Sony Vaio PCG-N505SN		??? (*)
 Sony Vaio vgn-s260		X or boot-radeon can init it (5)

-- 
teflon -- maybe it is a trademark, but it should not be.
