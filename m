Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUHJTC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUHJTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUHJTCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:02:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4065 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267487AbUHJTBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:01:13 -0400
Date: Tue, 10 Aug 2004 21:01:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810190102.GS26174@fs.tum.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810153333.GF13369@suse.de> <20040810162951.GC1127@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810162951.GC1127@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 06:29:51PM +0200, Jan-Benedict Glaw wrote:
>...
> So I think IFF you (as a distro) attempt to do any changes (be it adding
> a well-selling feature like DVD toasting), you *will* somewhen reach a
> critical mass: the point of no return (of good patches).
> 
> Seems we're slowly reaching there. (I'm just waiting to see a giant Arch
> repo of a single, unified Linux distro because of that.)
> 
> > > While they (and any other distro's people and anybody else) may
> > > actually hack the code to no end, I consider it being good habit to
> > 
> > By far the largest modification is dvd support, which we of course need
> > to ship. The rest is really minor stuff.
> 
> What's more important to whom? First ship the feature, or first getting
> consens with the initial author? Exactly--there are two answers:(

Joerg offers his own non-free program cdrecord-ProDVD with DVD support.

So why should he ever add DVD support to the GPLed cdrecord, no matter 
how good the patches are?

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

