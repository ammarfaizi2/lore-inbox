Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWJLROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWJLROE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJLROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:14:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751421AbWJLRN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:13:59 -0400
Subject: [PATCH 7/7] [GFS2] Update git tree name/location
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:19:15 +0100
Message-Id: <1160673555.11901.822.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 370298e2e6f513bc4a9e9445eeed060d8c31f1ca Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 12 Oct 2006 15:40:05 -0400
Subject: [GFS2] Update git tree name/location

The plan is to have two trees. One for bug fixes to be sent on a
regular basis (-fixes) and another called -nmw which will contain items
queued for the next merge window (hence the name). The -nmw tree
will come & go according to need.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 MAINTAINERS |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 931e6e4..1b5430a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,7 +905,8 @@ P:	David Teigland
 M:	teigland@redhat.com
 L:	cluster-devel@redhat.com
 W:	http://sources.redhat.com/cluster/
-T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs-2.6.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw.git
 S:	Supported
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
@@ -1188,7 +1189,8 @@ P:	Steven Whitehouse
 M:	swhiteho@redhat.com
 L:	cluster-devel@redhat.com
 W:	http://sources.redhat.com/cluster/
-T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs-2.6.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git
+T:	git kernel.org:/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw.git
 S:	Supported
 
 GIGASET ISDN DRIVERS
-- 
1.4.1



