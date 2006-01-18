Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWASABd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWASABd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWARX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:39 -0500
Received: from [151.97.230.9] ([151.97.230.9]:11241 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030488AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/8] uml: typo fixup
Date: Thu, 19 Jan 2006 00:54:57 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235454.4626.60041.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial innocent cosmetical fixup.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/ldt-x86_64.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-um/ldt-x86_64.h b/include/asm-um/ldt-x86_64.h
index 175722a..57159f1 100644
--- a/include/asm-um/ldt-x86_64.h
+++ b/include/asm-um/ldt-x86_64.h
@@ -5,8 +5,8 @@
  * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
  */
 
-#ifndef __ASM_LDT_I386_H
-#define __ASM_LDT_I386_H
+#ifndef __ASM_LDT_X86_64_H
+#define __ASM_LDT_X86_64_H
 
 #include "asm/semaphore.h"
 #include "asm/arch/ldt.h"

