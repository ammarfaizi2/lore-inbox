Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUFINME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUFINME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbUFINLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:11:37 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:18583 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263663AbUFINK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:10:58 -0400
Date: Wed, 9 Jun 2004 15:10:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: nathans@sgi.com, linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in xfs
Message-ID: <20040609131049.GN21168@wohnheim.fh-wedel.de>
References: <20040609122647.GF21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609122647.GF21168@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And since I don't like bounces, how about this patch?

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

 MAINTAINERS |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.6cow/MAINTAINERS~xfs_list	2004-05-10 18:10:05.000000000 +0200
+++ linux-2.6.6cow/MAINTAINERS	2004-06-09 15:08:08.000000000 +0200
@@ -2354,7 +2354,7 @@
 
 XFS FILESYSTEM
 P:	Silicon Graphics Inc
-M:	owner-xfs@oss.sgi.com
+M:	linux-xfs@oss.sgi.com
 M:	nathans@sgi.com
 L:	linux-xfs@oss.sgi.com
 W:	http://oss.sgi.com/projects/xfs
