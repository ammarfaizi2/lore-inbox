Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbUCZAIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbUCZAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:08:16 -0500
Received: from waste.org ([209.173.204.2]:7066 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263813AbUCYX7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:59:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <22.524465763@selenic.com>
Message-Id: <23.524465763@selenic.com>
Subject: [PATCH 22/22] /dev/random: update credits
Date: Thu, 25 Mar 2004 17:57:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  update credits

Update dates, add contact info


 tiny-mpm/drivers/char/random.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/random.c~random-credit drivers/char/random.c
--- tiny/drivers/char/random.c~random-credit	2004-03-20 13:38:53.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:53.000000000 -0600
@@ -1,8 +1,8 @@
 /*
  * random.c -- A strong random number generator
  *
- * Version 1.89, last modified 19-Sep-99
- * 
+ * Version 1.99  Matt Mackall <mpm@selenic.com> Oct 2003
+ *
  * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
  * rights reserved.
  *

_
