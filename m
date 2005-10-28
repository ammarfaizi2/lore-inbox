Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVJ1M1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVJ1M1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 08:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVJ1M1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 08:27:11 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56020 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965222AbVJ1M1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 08:27:10 -0400
Message-Id: <200510281226.j9SCQt3w005832@laptop11.inf.utfsm.cl>
To: coreteam@netfilter.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix typo
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 28 Oct 2005 09:26:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 28 Oct 2005 09:26:56 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1128458496 -0400

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>


---

 net/ipv4/netfilter/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 773021ad63126ff2dacff654bd41b03a4ad6389e
559144e679f79e29738fd9567cd58a77a027e587
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 2cd7e7d..a765972 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -141,7 +141,7 @@ config IP_NF_PPTP
 	tristate  'PPTP protocol support'
 	help
 	  This module adds support for PPTP (Point to Point Tunnelling
-	  Protocol, RFC2637) conncection tracking and NAT. 
+	  Protocol, RFC2637) connection tracking and NAT. 
 	
 	  If you are running PPTP sessions over a stateful firewall or NAT
 	  box, you may want to enable this feature.  
---
0.99.8.GIT
