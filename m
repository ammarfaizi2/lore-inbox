Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTFHLpK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTFHLpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:45:10 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:60095 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261589AbTFHLpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:45:08 -0400
Date: Sun, 8 Jun 2003 13:58:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: compaqandlinux@cpqlin.van-dijk.net
Subject: [PATCH] MAINTAINERS: compaq raid drivers
Message-ID: <20030608115844.GC6662@wohnheim.fh-wedel.de>
References: <200306072357.QAA04100@hpat542.atl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306072357.QAA04100@hpat542.atl.hp.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

"Charles White <arrays@compaq.com>" bounces.  Does anyone have a
better patch for the MAINTAINERS than the one below?

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law

--- linux-2.5.70-bk12/MAINTAINERS~maintainer_cpqarray	2003-06-08 00:40:50.000000000 +0200
+++ linux-2.5.70-bk12/MAINTAINERS	2003-06-08 13:53:05.000000000 +0200
@@ -404,14 +404,12 @@
 
 COMPAQ SMART2 RAID DRIVER
 P:	Charles White	
-M:	Charles White <arrays@compaq.com>
 L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux
 S:	Supported	
 
 COMPAQ SMART CISS RAID DRIVER 
 P:	Charles White
-M:	Charles White <arrays@compaq.com>
 L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux	
 S:	Supported 
