Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUIWBQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUIWBQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUIWBQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:16:17 -0400
Received: from [12.177.129.25] ([12.177.129.25]:65475 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267928AbUIWBQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:16:00 -0400
Message-Id: <200409230221.i8N2L4iF004265@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Remove an unused header
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:21:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/mprot.h
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/mprot.h	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/mprot.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,6 +0,0 @@
-#ifndef __MPROT_H__
-#define __MPROT_H__
-
-extern void no_access(unsigned long addr, unsigned int len);
-
-#endif

