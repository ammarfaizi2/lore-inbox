Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWHPAqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWHPAqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHPAqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:46:51 -0400
Received: from [63.64.152.142] ([63.64.152.142]:36105 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1750823AbWHPAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:46:03 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/7] [I/OAT] Add entries to MAINTAINERS for the DMA memcpy subsystem and ioatdma
Date: Tue, 15 Aug 2006 17:53:50 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060816005350.8634.68292.stgit@gitlost.site>
In-Reply-To: <20060816005337.8634.70033.stgit@gitlost.site>
References: <20060816005337.8634.70033.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21116cc..9ae73c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -881,6 +881,11 @@ M:	tori@unhappy.mine.nu
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+DMA GENERIC MEMCPY SUBSYSTEM
+P:	Chris Leech
+M:	christopher.leech@intel.com
+S:	Maintained
+
 DOCBOOK FOR DOCUMENTATION
 P:	Martin Waitz
 M:	tali@admingilde.org
@@ -1469,6 +1474,11 @@ P:	Tigran Aivazian
 M:	tigran@veritas.com
 S:	Maintained
 
+INTEL I/OAT DMA DRIVER
+P:	Chris Leech
+M:	christopher.leech@intel.com
+S:	Supported
+
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 P:	Deepak Saxena
 M:	dsaxena@plexity.net

