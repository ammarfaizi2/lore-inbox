Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWHOS6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWHOS6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWHOS6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:58:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12816 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965205AbWHOS6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:58:42 -0400
Date: Mon, 14 Aug 2006 21:44:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
Message-ID: <20060814214442.GB4032@ucw.cz>
References: <1155172597.3161.72.camel@localhost.localdomain> <44DACB21.9080002@garzik.org> <44DB5FC0.5070405@us.ibm.com> <20060810100012.abc1b5a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810100012.abc1b5a1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We do maintain a quilt(akpm) style patches on http://ext2.sf.net, the 
> > latest patches are always at 
> > http://ext2.sourceforge.net/48bitext3/patches/latest/
> > 
> > We thought about doing git initially, still open for that doing do, if 
> > it's more preferable by Linus or Andrew. Just thought  it's a lot 
> > easiler for non git user to pull the patches from a project website.
> > 
> 
> We should aim to get the big copy-ext3-to-ext4 patch into Linus's tree as
> early as possible.
> 
> I'm just not sure when to do that.  Immediately after 2.6.19-rc1 is
> released would be good because it is when every tree (including -mm) is in
> its most-synced-up state.

Or you could simply do it _now_. Its new-driver-like, so freeze should
not apply :-).

-- 
Thanks for all the (sleeping) penguins.
