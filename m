Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSJKLvk>; Fri, 11 Oct 2002 07:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbSJKLvk>; Fri, 11 Oct 2002 07:51:40 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:17679
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S262402AbSJKLvk>; Fri, 11 Oct 2002 07:51:40 -0400
Subject: oops typo patch [2.5.41] to compile drivers/block/cpqarray.c
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 11 Oct 2002 07:52:23 -0400
Message-Id: <1034337144.1629.350.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux/drivers/block/cpqarray.orig	Fri Oct 11 07:47:49 2002
+++ linux/drivers/block/cpqarray.c	Fri Oct 11 07:48:02 2002
@@ -437,7 +437,6 @@
 	}
 	return 0;
 }
-}




