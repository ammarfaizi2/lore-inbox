Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTBEXTv>; Wed, 5 Feb 2003 18:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTBEXTu>; Wed, 5 Feb 2003 18:19:50 -0500
Received: from bitmover.com ([192.132.92.2]:31672 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261600AbTBEXTu>;
	Wed, 5 Feb 2003 18:19:50 -0500
Date: Wed, 5 Feb 2003 15:29:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205232922.GA14131@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	lm@bitmover.com, linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205195151.GJ19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205195151.GJ19678@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it might be simply an error in the tarball, maybe Linus's tree isn't in
> full sync with bk head. But something definitely is corrupt between
> tarball and bk.

That is an incorrect statement.  You are comparing a moving target with
a snapshot.  If you roll the moving target back to the snapshot point
you get the tarball contents.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
