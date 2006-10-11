Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161462AbWJKVPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWJKVPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161470AbWJKVPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:15:03 -0400
Received: from av2.karneval.cz ([81.27.192.122]:65059 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1161467AbWJKVOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:14:37 -0400
Message-id: <8974328973221213@karneval.cz>
Subject: [PATCH] maintainers: add me to isicom, mxser
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 11 Oct 2006 23:14:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maintainers: add me to isicom, mxser

I can maintain moxa and isicom char drivers, because I've rewritten them to
the new API.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d2feb2fd87cc5e7db4cd8e8ddd910d9d2d6cebf1
tree 664ff80a517947d6766d80da81e8421eae1f6825
parent b2090dd621f58423950e8e79b0959889d26a8227
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:09:49 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:09:49 +0200

 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4563ce..97beb1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2020,6 +2020,11 @@ M:	rubini@ipvvis.unipv.it
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MOXA SMARTIO/INDUSTIO SERIAL CARD (MXSER 2.0)
+P:	Jiri Slaby
+M:	jirislaby@gmail.com
+S:	Maintained
+
 MSI LAPTOP SUPPORT
 P:	Lennart Poettering
 M:	mzxreary@0pointer.de
@@ -2042,6 +2047,11 @@ P:	Andrew Veliath
 M:	andrewtv@usa.net
 S:	Maintained
 
+MULTITECH MULTIPORT CARD (ISICOM)
+P:	Jiri Slaby
+M:	jirislaby@gmail.com
+S:	Maintained
+
 NATSEMI ETHERNET DRIVER (DP8381x)
 P: 	Tim Hockin
 M:	thockin@hockin.org
