Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVIHJLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVIHJLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 05:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIHJLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 05:11:51 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:34579 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932430AbVIHJLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 05:11:50 -0400
Date: Thu, 8 Sep 2005 11:11:49 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: shemminger@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: SKGE Kconfig help text typo fix
Message-ID: <Pine.LNX.4.61.0509081102500.19683@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SKGE surely isn't a meta driver. Not that this is relevant at all...

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>

--- linux-2.6.13/drivers/net/Kconfig	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-skge/drivers/net/Kconfig	2005-09-08 10:57:38.000000000 +0200
@@ -1928,7 +1928,7 @@ config SKGE
 	---help---
 	  This driver support the Marvell Yukon or SysKonnect SK-98xx/SK-95xx
 	  and related Gigabit Ethernet adapters. It is a new smaller driver
-	  driver with better performance and more complete ethtool support.
+	  with better performance and more complete ethtool support.
 
 	  It does not support the link failover and network management 
 	  features that "portable" vendor supplied sk98lin driver does.
