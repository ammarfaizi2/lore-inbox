Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVBABVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVBABVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 20:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVBABVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 20:21:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261449AbVBABVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 20:21:50 -0500
Date: Tue, 1 Feb 2005 02:21:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: [2.6 patch] mm/rmap.c: update the email address of Rik van Riel
Message-ID: <20050201012148.GF8722@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the email address of Rik van Riel in mm/rmap.c from a 
bouncing address to his current address.

This patch was already ACK'ed by Rik van Riel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/mm/rmap.c.old	2005-01-31 22:47:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/mm/rmap.c	2005-01-31 22:48:13.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * mm/rmap.c - physical to virtual reverse mappings
  *
- * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
+ * Copyright 2001, Rik van Riel <riel@redhat.com>
  * Released under the General Public License (GPL).
  *
  * Simple, low overhead reverse mapping scheme.
@@ -11,7 +11,7 @@
  * the anon methods track anonymous pages, and
  * the file methods track pages belonging to an inode.
  *
- * Original design by Rik van Riel <riel@conectiva.com.br> 2001
+ * Original design by Rik van Riel <riel@redhat.com> 2001
  * File methods by Dave McCracken <dmccr@us.ibm.com> 2003, 2004
  * Anonymous methods by Andrea Arcangeli <andrea@suse.de> 2004
  * Contributions by Hugh Dickins <hugh@veritas.com> 2003, 2004


