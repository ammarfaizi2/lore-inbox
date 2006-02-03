Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945984AbWBCVch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945984AbWBCVch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945985AbWBCVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:32:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15886 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945983AbWBCVcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:32:36 -0500
Date: Fri, 3 Feb 2006 22:32:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] schedule eepro100.c for removal
Message-ID: <20060203213234.GS4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Jan 2006

--- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old	2006-01-18 08:38:57.000000000 +0100
+++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt	2006-01-18 08:39:59.000000000 +0100
@@ -164,0 +165,6 @@
+---------------------------
+
+What:   eepro100 network driver
+When:   April 2006
+Why:    replaced by the e100 driver
+Who:    Adrian Bunk <bunk@stusta.de>

