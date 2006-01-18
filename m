Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWARHZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWARHZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWARHZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:25:37 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:23749 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1030290AbWARHZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:25:15 -0500
Date: Wed, 18 Jan 2006 15:24:40 +0800
Message-Id: <200601180724.k0I7OeCg006219@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 13/13] autofs4 - increase module version
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
