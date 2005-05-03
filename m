Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVECDKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVECDKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVECDKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:10:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9945 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261331AbVECDKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:10:03 -0400
Date: Mon, 2 May 2005 20:08:10 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update dontdiff
Message-ID: <20050502200810.A25764@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additions to the dontdiff list. Please apply.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit 576c741ef652e8767c14665eea190285f9a52263
tree 50f4cffc46b6487467aafbe1a07aefe1f0ae7e9c
parent ac09f698f1cda91e890fb75f4cb38253d60ff017
author Matt Porter <mporter@kernel.crashing.org> 1115081127 -0700
committer Matt Porter <mporter@kernel.crashing.org> 1115081127 -0700

Index: Documentation/dontdiff
===================================================================
--- f71a88464e5b5cb3f5246367bcc8ea0890f5fb0d/Documentation/dontdiff  (mode:100644 sha1:7c2496426ab9bd319065392a00d3fdb45270c6c5)
+++ 50f4cffc46b6487467aafbe1a07aefe1f0ae7e9c/Documentation/dontdiff  (mode:100644 sha1:9a33bb94f74fef59de103db9cc92adeaeb030680)
@@ -27,6 +27,7 @@
 *.so
 *.tex
 *.ver
+*.xml
 *_MODULES
 *_vga16.c
 *cscope*
@@ -110,6 +111,7 @@
 mktables
 modpost
 modversions.h*
+offsets.h
 oui.c*
 parse.c*
 parse.h*
@@ -134,4 +136,5 @@
 vmlinux.lds
 vsyscall.lds
 wanxlfw.inc
+uImage
 zImage
