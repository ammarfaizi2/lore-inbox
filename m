Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRDMNag>; Fri, 13 Apr 2001 09:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRDMNa0>; Fri, 13 Apr 2001 09:30:26 -0400
Received: from [216.151.155.121] ([216.151.155.121]:59402 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131254AbRDMNaR>; Fri, 13 Apr 2001 09:30:17 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: db@zigo.dhs.org (Dennis Bjorklund), linux-kernel@vger.kernel.org
Subject: Re: Data-corruption bug in VIA chipsets
In-Reply-To: <E14o3HM-0002pm-00@the-village.bc.nu>
From: Doug McNaught <doug@wireboard.com>
Date: 13 Apr 2001 09:29:59 -0400
In-Reply-To: Alan Cox's message of "Fri, 13 Apr 2001 14:06:22 +0100 (BST)"
Message-ID: <m38zl5exm0.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Here might be one of the resons for the trouble with VIA chipsets:
> > 
> > http://www.theregister.co.uk/content/3/18267.html
> > 
> > Some DMA error corrupting data, sounds like a really nasty bug. The
> > information is minimal on that page.
> 
> What annoys me is that we've known about the problem for _ages_. If you look
> the 2.4 kernel has experimental workarounds for this problem. VIA never once
> even returned an email to say 'we are looking into this'. Instead people sat
> there flashing multiple BIOS images and seeing what made the difference.

Is this problem likely to affect 2.2.X?  I have a VIA-based board on
order (Tyan Trinity) and I don't plan to run 2.4 on it anytime soon
(it's upgrading a stock RH6.2 box).

Am I safe if I stay in PIO mode?

-Doug
