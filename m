Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFDIfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFDIfw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFDIfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:35:52 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:11536 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261294AbVFDIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:35:46 -0400
Date: Sat, 4 Jun 2005 16:25:50 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Michael Blandford <michael@kmaclub.com>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] autofs4 - subversion bump to identify these changes
Message-ID: <Pine.LNX.4.62.0506041621550.8502@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.6, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry Andrew I forgot the signed off clause on the last 2 patches in this
series. Please accept them as if I had.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.12-rc5-mm2/include/linux/auto_fs4.h.version-bump	2005-06-04 16:14:42.000000000 +0800
+++ linux-2.6.12-rc5-mm2/include/linux/auto_fs4.h	2005-06-04 16:14:59.000000000 +0800
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	4
 
-#define AUTOFS_PROTO_SUBVERSION		6
+#define AUTOFS_PROTO_SUBVERSION		7
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
