Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUH1QDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUH1QDs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUH1QCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:02:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48556 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267232AbUH1QCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:02:36 -0400
Date: Fri, 27 Aug 2004 23:23:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: vfs2 (was Re: silent semantic changes with reiser4)
Message-ID: <20040827212339.GF709@openzaurus.ucw.cz>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412D9FE6.9050307@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Yes, but I didn't say "flame Christoph and ignore the issues" ;)
> > 
> >
> Oh....;-)
...
> enhancements.  This metafiles and file-directories stuff is actually 
> fairly trivial stuff.

Now I'm scared.

not as powerful.  Don't 
> move reiser4 into vfs, use reiser4 as the vfs.  Don't write 
> filesystems, write file plugins and disk format plugins and all the 
> other kinds of plugins, and you won't be missing any expressive power 
> that you really want....

So you want to replace vfs. Fine, but you should have told us before.

Also vfs replacement probably should not be hidden in fs/reiserfs4...


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

