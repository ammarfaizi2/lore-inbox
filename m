Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWJRUQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWJRUQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422852AbWJRUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:9138 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWJRUJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:16 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Diego Calleja <diegocg@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/16] HOWTO: bug report addition
Date: Wed, 18 Oct 2006 13:08:55 -0700
Message-Id: <11612021563449-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202153578-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diego Calleja <diegocg@gmail.com>

I suspect that not many people is subscribed to the bugzilla mailing list,
not surprising since the URLs doesn't seem to be in the tree :)

After fixing my english, I wonder if the following patch could be applied...

Signed-off-by: Diego Calleja <diegocg@gmail.com>
Acked-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/HOWTO |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/HOWTO b/Documentation/HOWTO
index d6f3dd1..8d51c14 100644
--- a/Documentation/HOWTO
+++ b/Documentation/HOWTO
@@ -395,6 +395,26 @@ bugme-janitor mailing list (every change
 
 
 
+Managing bug reports
+--------------------
+
+One of the best ways to put into practice your hacking skills is by fixing
+bugs reported by other people. Not only you will help to make the kernel
+more stable, you'll learn to fix real world problems and you will improve
+your skills, and other developers will be aware of your presence. Fixing
+bugs is one of the best ways to get merits among other developers, because
+not many people like wasting time fixing other people's bugs.
+
+To work in the already reported bug reports, go to http://bugzilla.kernel.org.
+If you want to be advised of the future bug reports, you can subscribe to the
+bugme-new mailing list (only new bug reports are mailed here) or to the
+bugme-janitor mailing list (every change in the bugzilla is mailed here)
+
+	http://lists.osdl.org/mailman/listinfo/bugme-new
+	http://lists.osdl.org/mailman/listinfo/bugme-janitors
+
+
+
 Mailing lists
 -------------
 
-- 
1.4.2.4

