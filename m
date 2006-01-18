Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWARGuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWARGuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWARGuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:50:37 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:54425 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1751356AbWARGuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:50:35 -0500
Date: Wed, 18 Jan 2006 14:49:14 +0800
Message-Id: <200601180649.k0I6nEO9005881@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Title: [PATCH 13/13] autofs4 - increase module version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update autofs4 version.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-rc1/include/linux/auto_fs4.h.version-bump	2005-12-10 13:56:03.000000000 +0800
+++ linux-2.6.15-rc1/include/linux/auto_fs4.h	2005-12-10 13:55:08.000000000 +0800
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	4
 
-#define AUTOFS_PROTO_SUBVERSION		7
+#define AUTOFS_PROTO_SUBVERSION		10
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
