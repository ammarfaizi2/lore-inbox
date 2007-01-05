Return-Path: <linux-kernel-owner+w=401wt.eu-S1422664AbXAESrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbXAESrl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbXAESrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:47:41 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34871 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422664AbXAESrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:40 -0500
Message-Id: <200701051842.l05IgFcD004627@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/9] UML - chan_user.h formatting fices
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace fixes and emacs comment removal.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/include/chan_user.h |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

Index: linux-2.6.18-mm/arch/um/include/chan_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_user.h	2007-01-01 13:30:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/chan_user.h	2007-01-01 13:31:11.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -54,14 +54,3 @@ __uml_help(fn, prefix "[0-9]*=<channel d
 );
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

