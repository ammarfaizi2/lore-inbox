Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVKGQva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVKGQva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVKGQva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:51:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30735 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932246AbVKGQv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:51:28 -0500
Date: Mon, 7 Nov 2005 17:51:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] GIT trivial tree
Message-ID: <20051107165126.GE3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git

I've taken over the trivial patch monkey from Rusty, and I'll send the 
really trivial patches like spelling corrections through this tree.

Is this tree OK or are there any problems with it?

Full patches currently in the tree below.


Adrian Bunk:
  I am the new monkey.
  Merge with http://www.kernel.org/.../torvalds/linux-2.6.git

Michal Wronski:
  Update Michal Wronski contact info


 CREDITS      |    6 ++----
 MAINTAINERS  |    6 +++---
 ipc/mqueue.c |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 5b1edf3..7fb4c73 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3642,11 +3642,9 @@ S: Beaverton, OR 97005
 S: USA
 
 N: Michal Wronski
-E: wrona@mat.uni.torun.pl
-W: http://www.mat.uni.torun.pl/~wrona
+E: Michal.Wronski@motorola.com
 D: POSIX message queues fs (with K. Benedyczak)
-S: ul. Teczowa 23/12
-S: 80-680 Gdansk-Sobieszewo
+S: Krakow
 S: Poland
 
 N: Frank Xia
diff --git a/MAINTAINERS b/MAINTAINERS
index d57c491..08dd21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2455,10 +2455,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
 TRIVIAL PATCHES
-P:      Rusty Russell
-M:      trivial@rustcorp.com.au
+P:      Adrian Bunk
+M:      trivial@kernel.org
 L:      linux-kernel@vger.kernel.org
-W:      http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
+W:      http://www.kernel.org/pub/linux/kernel/people/bunk/trivial/
 S:      Maintained
 
 TMS380 TOKEN-RING NETWORK DRIVER
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a0f18c9..c8943b5 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -2,7 +2,7 @@
  * POSIX message queues filesystem for Linux.
  *
  * Copyright (C) 2003,2004  Krzysztof Benedyczak    (golbi@mat.uni.torun.pl)
- *                          Michal Wronski          (wrona@mat.uni.torun.pl)
+ *                          Michal Wronski          (Michal.Wronski@motorola.com)
  *
  * Spinlocks:               Mohamed Abbas           (abbas.mohamed@intel.com)
  * Lockless receive & send, fd based notify:

