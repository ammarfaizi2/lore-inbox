Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTFHLvS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTFHLvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:51:18 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:63935 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261603AbTFHLvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:51:17 -0400
Date: Sun, 8 Jun 2003 14:04:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: compaq raid drivers
Message-ID: <20030608120453.GD6662@wohnheim.fh-wedel.de>
References: <200306072357.QAA04100@hpat542.atl.hp.com> <20030608115844.GC6662@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030608115844.GC6662@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 June 2003 13:58:44 +0200, Jörn Engel wrote:
> 
> "Charles White <arrays@compaq.com>" bounces.  Does anyone have a
> better patch for the MAINTAINERS than the one below?

Could have guessed so, the list bounces as well.  And so does the
other compaq address.  Updated patch.

Linus, any reasons not to apply such a patch?

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra

--- linux-2.5.70-bk12/MAINTAINERS~maintainer_cpqarray	2003-06-08 00:40:50.000000000 +0200
+++ linux-2.5.70-bk12/MAINTAINERS	2003-06-08 14:00:30.000000000 +0200
@@ -397,24 +397,18 @@
 
 COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
 P:	Amy Vanzant-Hodge 
-M:	Amy Vanzant-Hodge (fibrechannel@compaq.com)
-L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux
-S:	Supported
+S:	Orphan
 
 COMPAQ SMART2 RAID DRIVER
 P:	Charles White	
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux
-S:	Supported	
+S:	Orphan
 
 COMPAQ SMART CISS RAID DRIVER 
 P:	Charles White
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux	
-S:	Supported 
+S:	Orphan
 
 COMPUTONE INTELLIPORT MULTIPORT CARD
 P:	Michael H. Warfield
