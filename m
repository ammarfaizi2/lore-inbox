Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWJKSVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWJKSVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWJKSVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:21:16 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:22672 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161173AbWJKSVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:21:15 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] New MMC maintainer
Date: Wed, 11 Oct 2006 20:21:13 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061011182113.20383.25321.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be taking over after Russell King as the new maintainer of the
MMC layer.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 MAINTAINERS |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 931e6e4..f724e1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2003,8 +2003,11 @@ L:	linux-kernel@vger.kernel.org
 W:	http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
 S:	Maintained
 
-MULTIMEDIA CARD (MMC) SUBSYSTEM
-S:	Orphan
+MULTIMEDIA CARD (MMC) AND SECURE DIGITAL (SD) SUBSYSTEM
+P:	Pierre Ossman
+M:	drzeus-mmc@drzeus.cx
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
 
 MULTISOUND SOUND DRIVER
 P:	Andrew Veliath

