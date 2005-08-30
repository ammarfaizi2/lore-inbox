Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVH3DSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVH3DSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVH3DSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:18:32 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:65413 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932106AbVH3DSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:18:31 -0400
X-IronPort-AV: i="3.96,152,1122872400"; 
   d="scan'208"; a="286436784:sNHT24676220"
Date: Mon, 29 Aug 2005 22:18:30 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: fcusack@fcusack.org, linux-kernel@vger.kernel.org,
       pptpclient-devel@lists.sourceforge.net
Subject: [PATCH 2.6.13-rc6-mm2] ppp_mppe: author email change
Message-ID: <20050830031830.GA12041@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cusack, primary author of the ppp_mppe kernel module, is no
longer at Google.  This updates his email address in the module, as
agreed to by Frank privately.

 ppp_mppe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -urNp --exclude-from=/home/mdomsch/excludes --minimal linux-2.6.13-rc6-mm2.orig/drivers/net/ppp_mppe.c linux-2.6.13-rc6-mm2/drivers/net/ppp_mppe.c
--- linux-2.6.13-rc6-mm2.orig/drivers/net/ppp_mppe.c	Mon Aug 29 22:08:58 2005
+++ linux-2.6.13-rc6-mm2/drivers/net/ppp_mppe.c	Mon Aug 29 22:10:23 2005
@@ -2,7 +2,7 @@
  * ppp_mppe.c - interface MPPE to the PPP code.
  * This version is for use with Linux kernel 2.6.14+
  *
- * By Frank Cusack <frank@google.com>.
+ * By Frank Cusack <fcusack@fcusack.com>.
  * Copyright (c) 2002,2003,2004 Google, Inc.
  * All rights reserved.
  *
@@ -59,7 +59,7 @@
 
 #include "ppp_mppe.h"
 
-MODULE_AUTHOR("Frank Cusack <frank@google.com>");
+MODULE_AUTHOR("Frank Cusack <fcusack@fcusack.com>");
 MODULE_DESCRIPTION("Point-to-Point Protocol Microsoft Point-to-Point Encryption support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_MPPE));
