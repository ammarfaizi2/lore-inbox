Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTHUSPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbTHUSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 14:15:18 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:48394 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262814AbTHUSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 14:15:14 -0400
Date: Thu, 21 Aug 2003 19:15:11 +0100
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove cramfs maintainership
Message-ID: <20030821191511.B2313@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

It appears as if Daniel doesn't want to be the maintainer any more, at
least he didn't reply to me.

Please apply.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu

--- linux-2.5.71/MAINTAINERS~cramfs_maintain	2003-06-15 16:04:45.000000000 +0200
+++ linux-2.5.71/MAINTAINERS	2003-06-15 19:23:29.000000000 +0200
@@ -426,10 +426,8 @@
 S:	Maintained
 
 CRAMFS FILESYSTEM
-P:	Daniel Quinlan
-M:	quinlan@transmeta.com
-W:	http://sourceforge.net/projects/cramfs/
-S:	Maintained
+W:     http://sourceforge.net/projects/cramfs/
+S:     Orphan
 
 CREDITS FILE
 P:	John A. Martin
