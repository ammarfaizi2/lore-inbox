Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUAGJuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAGJuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:50:03 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:12392 "EHLO
	steelemr-loadb-nat-49.caltech.edu") by vger.kernel.org with ESMTP
	id S265463AbUAGJuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:50:00 -0500
Date: Wed, 7 Jan 2004 01:49:58 -0800
From: Bryan Rittmeyer <bryanrNO@SPAMcaltech.edu>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH][2.6][TRIVIAL][SPELLING] OTHO->OTOH
Message-ID: <20040107094957.GA12409@clyde.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent twenty obscene seconds attempting to expand "OTHO".
All of my proposals are unpublishable, so here's a trivial patch.

-Bryan

--- linux-2.6.1-rc2/mm/slab.c.orig      2004-01-07 00:22:47.690367720 -0800
+++ linux-2.6.1-rc2/mm/slab.c   2004-01-07 00:23:17.211879768 -0800
@@ -307,7 +307,7 @@
 /* Optimization question: fewer reaps means less 
  * probability for unnessary cpucache drain/refill cycles.
  *
- * OTHO the cpuarrays can contain lots of objects,
+ * OTOH the cpuarrays can contain lots of objects,
  * which could lock up otherwise freeable slabs.
  */
 #define REAPTIMEOUT_CPUC       (2*HZ)

