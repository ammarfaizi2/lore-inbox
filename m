Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbULYNoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbULYNoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbULYNmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:42:25 -0500
Received: from golobica.uni-mb.si ([164.8.100.4]:52688 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S261485AbULYNlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:41:35 -0500
Subject: [patch 4/4] delete unused file
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 14:41:37 +0100
Message-Id: <20041225134127.EE9D64DC08C@golobica.uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-alpha/numnodes.h |    7 -------
 1 files changed, 7 deletions(-)

diff -L include/asm-alpha/numnodes.h -puN include/asm-alpha/numnodes.h~remove_file-include_asm_alpha_numnodes.h /dev/null
--- kj/include/asm-alpha/numnodes.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/* Max 128 Nodes - Marvel */
-#define NODES_SHIFT	7
-
-#endif /* _ASM_MAX_NUMNODES_H */
_
