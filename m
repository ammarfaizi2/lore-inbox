Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJDHEB>; Fri, 4 Oct 2002 03:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSJDHEB>; Fri, 4 Oct 2002 03:04:01 -0400
Received: from 62-190-218-239.pdu.pipex.net ([62.190.218.239]:13060 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261509AbSJDHEA>; Fri, 4 Oct 2002 03:04:00 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210040717.g947Hx2P000478@darkstar.example.net>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
To: greg@kroah.com (Greg KH)
Date: Fri, 4 Oct 2002 08:17:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021004063738.GB4260@kroah.com> from "Greg KH" at Oct 03, 2002 11:37:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Hmmm, then for 3.0 I'd vote for fully working and proven stable:
> > > 
> > > Hm, how do you "prove" any of these are stable :)
> > 
> > Hmm, yeah, I see what you mean, but for me, proved stable is a couple
> > of years of being in a major distribution, with people actually using
> > it.
> 
> Ah, so no one actually uses those things in your list.  So glad to hear
> that...

Whatever.  I wouldn't call them 3.0 material yet - would you?

> > > > * USB (2)
> > > 
> > > Present in 2.5 (and 2.4 now too)
> > 
> > ..and yet there are still complaints that it doesn't work every day on the list.
> 
> Hm, must have missed those.  I haven't seen any USB 2.0 complaints in
> quite some time.  The majority of USB "issues" are crappy usb storage
> devices that don't match the USB storage spec, or PCI IRQ routing
> problems.

We have to code for the devices that are out there.  Big deal if we follow the spec to the letter - if Mr Average plugs in his USB device and it doesn't work, well, it doesn't work.  It's no good lecturing him on the spec.  I don't usually take that view, but when there are a large number of broken devices, what are the other options?

> But hey, no one cares about USB, I'm used to it :)

I certainly don't care about USB, I don't even have a USB port on my main box, but if you're saying that the current support is 3.0 material, then I totally disagree.

I started this thread because I'd originally thought that 1.x.x -> 2.x.x happened due to moving from a.out to elf as the standard binary format.  Linus corrected me on that one, and pointed out that it was major feature enhancements that dictate the major version number change.  Given that, I am not in any hurry to see it move to 3.0.0  :-).

John.
