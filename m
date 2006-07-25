Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWGYQN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWGYQN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWGYQN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:13:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:53223 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964784AbWGYQN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:13:29 -0400
Subject: [PATCH] Fix typo in MAINTAINERS: s/DEVICS/DEVICES/
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, trivial@kernel.org
Content-Type: text/plain
Date: Tue, 25 Jul 2006 09:13:29 -0700
Message-Id: <1153844009.12517.28.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2afc7a..0a3a9d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,7 +1598,7 @@ W:	http://jfs.sourceforge.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git
 S:	Supported
 
-JOURNALLING LAYER FOR BLOCK DEVICS (JBD)
+JOURNALLING LAYER FOR BLOCK DEVICES (JBD)
 P:	Stephen Tweedie, Andrew Morton
 M:	sct@redhat.com, akpm@osdl.org
 L:	ext2-devel@lists.sourceforge.net


