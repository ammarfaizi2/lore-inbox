Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULXAaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULXAaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULXAaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:30:55 -0500
Received: from mail.dif.dk ([193.138.115.101]:48835 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261336AbULXAav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:30:51 -0500
Date: Fri, 24 Dec 2004 01:41:40 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rik van Riel <riel@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] update bouncing email addr. of Rik van Riel
Message-ID: <Pine.LNX.4.61.0412240139240.3504@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The address listed in mm/rmap.c (riel@conectiva.com.br) seems to bounce, 
relace it with a working address (riel@redhat.com).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk16-orig/mm/rmap.c	2004-12-23 23:26:50.000000000 +0100
+++ linux-2.6.10-rc3-bk16/mm/rmap.c	2004-12-24 01:39:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * mm/rmap.c - physical to virtual reverse mappings
  *
- * Copyright 2001, Rik van Riel <riel@conectiva.com.br>
+ * Copyright 2001, Rik van Riel <riel@redhat.com>
  * Released under the General Public License (GPL).
  *
  * Simple, low overhead reverse mapping scheme.


