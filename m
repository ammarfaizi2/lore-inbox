Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTEXU5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 16:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTEXU5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 16:57:35 -0400
Received: from web40016.mail.yahoo.com ([66.218.78.56]:44105 "HELO
	web40016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261161AbTEXU5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 16:57:34 -0400
Message-ID: <20030524211042.92433.qmail@web40016.mail.yahoo.com>
Date: Sat, 24 May 2003 14:10:42 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: [2.5.69 PATCH] - Trivial patch to Netfilter Kconfig
To: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       zippel@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected grammar and misspelling and made description more consistent.
  -- Jeff Smith

========================================================================
--- a/net/ipv4/netfilter/Kconfig        Sun May  4 18:53:37 2003
+++ b/net/ipv4/netfilter/Kconfig        Sat May 24 15:53:17 2003
@@ -120,7 +120,7 @@
        tristate "Packet type match support"
        depends on IP_NF_IPTABLES
        help
-         This patch allows you to match packet in accrodance
+         Packet type matching allows you to match a packet in accordance
          to its "class", eg. BROADCAST, MULTICAST, ...

          Typical usage:


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
