Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIRjq>; Tue, 9 Jan 2001 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRAIRjI>; Tue, 9 Jan 2001 12:39:08 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:45586 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129324AbRAIRiz>; Tue, 9 Jan 2001 12:38:55 -0500
Date: Tue, 9 Jan 2001 09:38:53 -0800
From: David Rees <dbr@spoke.nols.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Invalid Netfilter URL in Documentation/Changes in 2.4.0
Message-ID: <20010109093853.C2201@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The link to http://www.samba.org/netfilter/iptables-1.1.1.tar.bz2 is 
invalid in 2.4.0, this patch simply removes the link.

-Dave

--- linux/Documentation/Changes.orig    Mon Jan  1 10:00:04 2001
+++ linux/Documentation/Changes Tue Jan  9 09:37:20 2001
@@ -336,7 +336,6 @@
 Netfilter
 ---------
 o  <http://netfilter.filewatcher.org/iptables-1.1.1.tar.bz2>
-o  <http://www.samba.org/netfilter/iptables-1.1.1.tar.bz2>
 o  <http://netfilter.kernelnotes.org/iptables-1.1.1.tar.bz2>
 
 Ip-route2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
