Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWHPQuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWHPQuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWHPQuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:50:01 -0400
Received: from [63.64.152.142] ([63.64.152.142]:40713 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S932108AbWHPQuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:50:00 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/7 v2] [I/OAT] Add entries to MAINTAINERS for the DMA memcpy subsystem and ioatdma
Date: Wed, 16 Aug 2006 09:57:47 -0700
To: rdunlap@xenotime.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060816165747.10162.11471.stgit@gitlost.site>
In-Reply-To: <Pine.LNX.4.58.0608152151430.7622@shark.he.net>
References: <Pine.LNX.4.58.0608152151430.7622@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21116cc..2d484aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -881,6 +881,12 @@ M:	tori@unhappy.mine.nu
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+DMA GENERIC MEMCPY SUBSYSTEM
+P:	Chris Leech
+M:	christopher.leech@intel.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 DOCBOOK FOR DOCUMENTATION
 P:	Martin Waitz
 M:	tali@admingilde.org
@@ -1469,6 +1475,12 @@ P:	Tigran Aivazian
 M:	tigran@veritas.com
 S:	Maintained
 
+INTEL I/OAT DMA DRIVER
+P:	Chris Leech
+M:	christopher.leech@intel.com
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 P:	Deepak Saxena
 M:	dsaxena@plexity.net

