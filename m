Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTH2UKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbTH2UJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:09:04 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:58273 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262055AbTH2UIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:08:01 -0400
Message-ID: <3F4FB2EE.8080509@terra.com.br>
Date: Fri, 29 Aug 2003 17:09:18 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 6/9] Remove unneeded linux/version.h from net/ipv4/netfilter/ip_nat_core
Content-Type: multipart/mixed;
 boundary="------------090505070401040800000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090505070401040800000800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------090505070401040800000800
Content-Type: text/plain;
 name="ip_nat_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip_nat_core.patch"

--- linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_core.c.orig	Fri Aug 29 16:44:38 2003
+++ linux-2.6.0-test4/net/ipv4/netfilter/ip_nat_core.c	Fri Aug 29 16:44:44 2003
@@ -2,7 +2,6 @@
 
 /* (c) 1999 Paul `Rusty' Russell.  Licenced under the GNU General
    Public Licence. */
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/timer.h>

--------------090505070401040800000800--

