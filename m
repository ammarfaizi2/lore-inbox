Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVCJNz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVCJNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCJNz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:55:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21677 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261244AbVCJNzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:55:23 -0500
Date: Sun, 6 Mar 2005 13:57:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050306125749.GO3485@openzaurus.ucw.cz>
References: <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de> <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org> <4228B514.4020704@keyaccess.nl> <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The fact that not a script, but Linus Torvalds, decides that the tree is 
> > in a state he likes to share with others. You have been doing -pre's all 
> > this time, it's just that you are calling them -rc's.
> 
> No.
> 
> I used to do "-pre", a long time ago. Exactly because they were 
> synchronization points for developers.
> 
> These days, that's pointless. We keep the tree in pretty good working
> order (certainly as good as my -pre's ever were) constantly, and
> developers who need to can synchronize with either the BK tree or the
> nightly snapshots. The fact is, 99% of the developers don't even need to 

Actually, sync to -pre is easier than sync to -bk snapshot:
* you get incremental patches from kernel.org
* there's reasonable number of pre-s so that you can be up-to-date without
syncing each day

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

