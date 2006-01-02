Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWABRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWABRXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWABRXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:23:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58119 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750881AbWABRXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:23:40 -0500
Date: Mon, 2 Jan 2006 18:23:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc7: known regressions
Message-ID: <20060102172340.GI17398@stusta.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <20060102164636.GH17398@stusta.de> <200601021807.52533.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601021807.52533.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 06:07:52PM +0100, Andi Kleen wrote:
> On Monday 02 January 2006 17:46, Adrian Bunk wrote:
> 
> > Subject    : x86_64: PANIC: early exception
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=5758
> > Status     : Andi considers his patch too risky for 2.6.15,
> >              workaround available, should be noted in the
> >              final 2.6.15 announcement
> 
> If it worked in 2.6.14 then only by extreme luck and probably
> also ran into problems later. The BIOS in this case is terminally broken. 
> 
> So I wouldn't consider this a real regression.

Unless I misread the Bugzilla bug, the submitter was extremely lucky
in 2.6.14 making it a regression for him.

But discussing this point won't buy us much.

Would you veto against a section "known regressions" in the final 2.6.15
announcement listing this issue with a link to the Bugzilla bug?

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

