Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTH2UIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbTH2UIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:08:07 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:16033 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262005AbTH2UHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:07:54 -0400
Message-ID: <3F4FB2E8.7030508@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:12 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 4/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_fw_compat_masq
Content-Type: multipart/mixed;
 boundary="------------040800050604000406000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040800050604000406000800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------040800050604000406000800
Content-Type: text/plain;
 name="ip_fw_compat_masq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_fw_compat_masq.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_fw_compat_masq.c.orig	Fri Aug 29 16:44:04 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_fw_compat_masq.c	Fri Aug 29 16:44:11 2003
@@ -13,7 +13,6 @@
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
 #include <linux/proc_fs.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <net/route.h>
 

--------------040800050604000406000800--

