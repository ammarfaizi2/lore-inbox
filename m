Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVACNrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVACNrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVACNrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:47:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261447AbVACNr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:47:29 -0500
Date: Mon, 3 Jan 2005 14:47:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Diego Calleja <diegocg@teleline.es>
Cc: Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, davidsen@tmr.com,
       aebr@win.tue.nl, solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103134727.GA2980@stusta.de>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050103142412.490239b8.diegocg@teleline.es>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 02:24:12PM +0100, Diego Calleja wrote:
> El Mon, 3 Jan 2005 06:33:04 +0100 Willy Tarreau <willy@w.ods.org> escribió:
> 
> > I clearly don't agree with you, for a simple reason : those out-of-tree
> > features will always be, because each distro likes to add a few features,
> > like SquashFS, PaX, etc... And indeed, that's one of the reasons I *stay*
> > on 2.4. It's so simple to simply upgrade the kernel, patch and recompile
> > without spending days complaining "grrr... why did they change this ?".
> 
> 
> 2.6 will stop having small issues in each release until 2.7 is forked just
> like 2.4 broke things until 2.5 was forked. The difference IMO
> is that linux development now avoids things like the unstability which the
> 2.4.10 changes caused and things like the fs corruption bugs we saw in 2.4
>...

The 2.6.9 -> 2.6.10 patch is 28 MB, and while the changes that went into 
2.4 were limited since the most invasive patches were postponed for 2.5, 
now _all_ patches go into 2.6 .

Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
enough for this vast amount of changes.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

