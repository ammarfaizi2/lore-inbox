Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVJDUq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVJDUq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVJDUq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:46:26 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:28591 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964966AbVJDUq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:46:26 -0400
Date: Tue, 4 Oct 2005 16:46:17 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-Id: <200510042046.j94KkHoN017884@laptop11.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org, vonbrand@inf.utfsm.cl
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 04 Oct 2005 16:46:23 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Fix typo
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: 1128458496 -0400

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>


---

 net/ipv4/netfilter/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

559144e679f79e29738fd9567cd58a77a027e587
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
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
