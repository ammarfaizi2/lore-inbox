Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263154AbSJHBDf>; Mon, 7 Oct 2002 21:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbSJHBDf>; Mon, 7 Oct 2002 21:03:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:24330 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S263154AbSJHBDb>; Mon, 7 Oct 2002 21:03:31 -0400
Date: Tue, 8 Oct 2002 02:09:11 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SubmittingPatches wrong indentation
Message-ID: <20021008010911.GA38160@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do I win "none more trivial" ?

Against 2.5.41

john


--- linux-linus/Documentation/SubmittingPatches	Thu Aug  1 22:16:03 2002
+++ linux/Documentation/SubmittingPatches	Sun Oct  6 00:41:12 2002
@@ -243,7 +243,7 @@
 	if (!dev)
 		return -ENODEV;
 	#ifdef CONFIG_NET_FUNKINESS
-		init_funky_net(dev);
+	init_funky_net(dev);
 	#endif
 
 Cleaned-up example:
