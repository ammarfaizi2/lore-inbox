Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279797AbRJ0IwA>; Sat, 27 Oct 2001 04:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279795AbRJ0Ivk>; Sat, 27 Oct 2001 04:51:40 -0400
Received: from [24.78.175.24] ([24.78.175.24]:46214 "EHLO oof.localnet")
	by vger.kernel.org with ESMTP id <S279792AbRJ0Ivb>;
	Sat, 27 Oct 2001 04:51:31 -0400
Date: Sat, 27 Oct 2001 01:52:06 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH: 2.4.14-pre3] Semicolon missing in pcd.c
Message-ID: <20011027015206.A30481@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/drivers/block/paride/pcd.c.orig	Sat Oct 27 01:33:27 2001
+++ linux/drivers/block/paride/pcd.c	Sat Oct 27 01:49:32 2001
@@ -271,7 +271,7 @@
 	release:		cdrom_release,
 	ioctl:			cdrom_ioctl,
 	check_media_change:	cdrom_media_changed,
-}
+};
 
 static struct cdrom_device_ops pcd_dops = {
 	pcd_open,

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
