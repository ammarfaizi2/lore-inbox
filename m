Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTFOROX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFOROW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:14:22 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:939 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262430AbTFORNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:13:55 -0400
Date: Sun, 15 Jun 2003 19:27:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615172747.GG1063@wohnheim.fh-wedel.de>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030615160524.GD1063@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 June 2003 18:05:24 +0200, Jörn Engel wrote:
> To:	quinlan@transmeta.com

And got a bounce.  Another free office over there, Linus?

Anyway, unless someone has a better patch, just remove him from
MAINTAINERS.

The sourceforge page is still informative, so I kept that in.

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000

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
