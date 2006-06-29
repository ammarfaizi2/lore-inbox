Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWF2SVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWF2SVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWF2SVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:21:42 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:11279 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751245AbWF2SVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:21:42 -0400
Date: Thu, 29 Jun 2006 14:20:39 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] net/ipv4/netfilter/Kconfig typo (Bugzilla #6753)
Message-Id: <20060629142039.c9954c45.laplam@rpi.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 14:20:51 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 14:20:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes bugzilla #6753, a typo in the netfilter Kconfig

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

--

--- a/net/ipv4/netfilter/Kconfig	2006-06-29 14:07:38.000000000 -0400
+++ b/net/ipv4/netfilter/Kconfig	2006-06-29 14:18:00.000000000 -0400
@@ -332,7 +332,7 @@
 	help
 	  This option adds a new iptables `hashlimit' match.  
 
-	  As opposed to `limit', this match dynamically crates a hash table
+	  As opposed to `limit', this match dynamically creates a hash table
 	  of limit buckets, based on your selection of source/destination
 	  ip addresses and/or ports.
 

