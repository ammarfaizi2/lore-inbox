Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTH2UNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbTH2UI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:29 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:49633 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262051AbTH2UHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:07:43 -0400
Message-ID: <3F4FB2DF.3090903@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:03 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 3/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ipfwadm_core
Content-Type: multipart/mixed;
 boundary="------------070703010107040306020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703010107040306020004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------070703010107040306020004
Content-Type: text/plain;
 name="ipfwadm_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipfwadm_core.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ipfwadm_core.c.orig	Fri Aug 29 16:45:40 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ipfwadm_core.c	Fri Aug 29 16:45:53 2003
@@ -131,7 +131,6 @@
 #include <net/checksum.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
-#include <linux/version.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
 

--------------070703010107040306020004--

