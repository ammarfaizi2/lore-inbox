Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945901AbWJRXjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901AbWJRXjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423170AbWJRXj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:39:29 -0400
Received: from [63.64.152.142] ([63.64.152.142]:53262 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423168AbWJRXjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:39:03 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 6/7] I/OAT: Add entries to MAINTAINERS for the DMA memcpy subsystem and ioatdma
Date: Wed, 18 Oct 2006 16:46:59 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234659.26671.29694.stgit@gitlost.site>
In-Reply-To: <20061018234417.26671.56773.stgit@gitlost.site>
References: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5305dd6..533adbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,6 +915,12 @@ M:	tori@unhappy.mine.nu
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
@@ -1516,6 +1522,12 @@ P:	Tigran Aivazian
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

