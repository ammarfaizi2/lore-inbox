Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVHOQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVHOQlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVHOQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:41:17 -0400
Received: from galileo.bork.org ([134.117.69.57]:38866 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S964840AbVHOQlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:41:16 -0400
Date: Mon, 15 Aug 2005 12:41:16 -0400
From: Martin Hicks <mort@sgi.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel M-L <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm: slab.c spelling correction
Message-ID: <20050815164116.GD13449@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


as the Subject says...

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com



Fix a small spelling mistake.  subtile->subtle

Signed-off-by:  Martin Hicks <mort@sgi.com>

---
commit fde14c4f6598615c97ec36dc327ec357044d50a1
tree 7d34f622a36d0920e6d77f2adfbe19b5501b9e76
parent ec3f303ed39a1fa9f66828bfa2d248b2e697544a
author Martin Hicks,,,,,,,engr <mort@tomahawk.engr.sgi.com> Mon, 15 Aug 2005 09:27:24 -0700
committer Martin Hicks,,,,,,,engr <mort@tomahawk.engr.sgi.com> Mon, 15 Aug 2005 09:27:24 -0700

 mm/slab.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -600,7 +600,7 @@ static inline kmem_cache_t *__find_gener
 		csizep++;
 
 	/*
-	 * Really subtile: The last entry with cs->cs_size==ULONG_MAX
+	 * Really subtle: The last entry with cs->cs_size==ULONG_MAX
 	 * has cs_{dma,}cachep==NULL. Thus no special case
 	 * for large kmalloc calls required.
 	 */
