Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVKVT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVKVT3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVKVT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:29:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18191 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965120AbVKVT27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:28:59 -0500
Date: Tue, 22 Nov 2005 20:28:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122192857.GB3963@stusta.de>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <17282.39560.978065.606788@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17282.39560.978065.606788@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 03:11:52PM +1100, Neil Brown wrote:
> On Monday November 21, jonsmirl@gmail.com wrote:
> > 
> > 2) Temporarily accept the ugly drivers. Let desktop development
> > continue. Work hard on getting the vendors to see the light and go
> > open source.
> 
> I doubt they will see 'the light' for many years without dollar signs
> attached.
> 
> A question worth asking is: Who needs whom?  Do we (FLOSS community)
> need them (Graphics hardware manufactures) or do they need us?
> Despite growth in Linux on Desktops, I think we need them a lot more
> than they need us.
>...
> Who is going to pay these people to do this work?  If you agree with
> the analysis of 'who needs whom', the logical answer is 'us'.
> 
> Maybe we need a small consortium of companies with vested interest in
> OSS each ponying up half a million, and use this to employ two teams
> of graphics experts, one of which works within NVidia, and one within
> ATI.  I suspect the two companies could be convinced to take on some
> free engineering support, if it was presented the right way.
>...

There might be a different way that could work if _many_ Linux-related 
companies participate:

Find a graphics card vendor who wants to offer a cheap graphics card 
while offering full specs and write an open source driver for this card.

Then start the PR campaign, e.g. press releases and free prominent 
notices at the SuSE main page "SuSE recommends ...".

Yes, this would require a significant joint effort.

But if successful, it might convince at least one of the two big 
graphics cards vendors that there's an (although relatively small) part 
of the market they are missing.

> NeilBrown

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

