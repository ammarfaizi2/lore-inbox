Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWHJUNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHJUNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHJUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:12:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:46480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932140AbWHJTgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:25 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [68/145] x86_64: Remove obsolete CVS $ from assembler files in arch/x86_64/kernel/*
Message-Id: <20060810193624.2793013C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:24 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

CVS hasn't been used for a long time for them.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |    2 --
 arch/x86_64/kernel/head.S  |    2 --
 2 files changed, 4 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -4,8 +4,6 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 2000, 2001, 2002  Andi Kleen SuSE Labs
  *  Copyright (C) 2000  Pavel Machek <pavel@suse.cz>
- * 
- *  $Id$
  */
 
 /*
Index: linux/arch/x86_64/kernel/head.S
===================================================================
--- linux.orig/arch/x86_64/kernel/head.S
+++ linux/arch/x86_64/kernel/head.S
@@ -5,8 +5,6 @@
  *  Copyright (C) 2000 Pavel Machek <pavel@suse.cz>
  *  Copyright (C) 2000 Karsten Keil <kkeil@suse.de>
  *  Copyright (C) 2001,2002 Andi Kleen <ak@suse.de>
- *
- *  $Id: head.S,v 1.49 2002/03/19 17:39:25 ak Exp $
  */
 
 
