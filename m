Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVLYSFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVLYSFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVLYSFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:05:11 -0500
Received: from mylar.outflux.net ([69.93.193.226]:33945 "EHLO
	mylar.outflux.net") by vger.kernel.org with ESMTP id S1750845AbVLYSFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:05:10 -0500
Date: Sun, 25 Dec 2005 10:05:02 -0800
From: Kees Cook <kees@outflux.net>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: bunk now maintains Trivial Patch Monkey
Message-ID: <20051225180502.GL18040@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HELO: ghostship.outflux.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking for where to send trivial patches, I found old contact
information in Documentation/SubmittingPatches.

Signed-off-by: Kees Cook <kees@outflux.net>

---

--- linux-2.6.15-rc7/Documentation/SubmittingPatches.orig	2005-12-25 09:53:52.000000000 -0800
+++ linux-2.6.15-rc7/Documentation/SubmittingPatches	2005-12-25 09:55:12.000000000 -0800
@@ -158,7 +158,7 @@ Even if the maintainer did not respond i
 copy the maintainer when you change their code.
 
 For small patches you may want to CC the Trivial Patch Monkey
-trivial@rustcorp.com.au set up by Rusty Russell; which collects "trivial"
+trivial@kernel.org managed by Adrian Bunk; which collects "trivial"
 patches. Trivial patches must qualify for one of the following rules:
  Spelling fixes in documentation
  Spelling fixes which could break grep(1).
@@ -171,7 +171,7 @@ patches. Trivial patches must qualify fo
  since people copy, as long as it's trivial)
  Any fix by the author/maintainer of the file. (ie. patch monkey
  in re-transmission mode)
-URL: <http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/>
+URL: <http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/>
 
 

-- 
Kees Cook                                            @outflux.net
