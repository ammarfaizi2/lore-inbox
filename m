Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTDVTSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTDVTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:18:53 -0400
Received: from web40001.mail.yahoo.com ([66.218.78.19]:32652 "HELO
	web40001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263389AbTDVTSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:18:33 -0400
Message-ID: <20030422193033.66675.qmail@web40001.mail.yahoo.com>
Date: Tue, 22 Apr 2003 12:30:33 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: [PATCH 2.5.68] Typo in a Kconfig file
To: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       zippel@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this typo in NetFilter's Kconfig file.
- Jeff Smith


--- a/net/ipv4/netfilter/Kconfig	Sat Apr 19 21:50:40 2003
+++ b/net/ipv4/netfilter/Kconfig	Tue Apr 22 12:04:59 2003
@@ -48,7 +48,7 @@
 	  <file:Documentation/modules.txt>.  If unsure, say `Y'.
 
 config IP_NF_TFTP
-	tristate "TFTP prtocol support"
+	tristate "TFTP protocol support"
 	depends on IP_NF_CONNTRACK
 	help
 	  TFTP connection tracking helper, this is required depending



__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
