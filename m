Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132764AbRDORpi>; Sun, 15 Apr 2001 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132771AbRDORp3>; Sun, 15 Apr 2001 13:45:29 -0400
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:46608 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S132764AbRDORpU>;
	Sun, 15 Apr 2001 13:45:20 -0400
Date: Sun, 15 Apr 2001 12:45:02 -0500 (CDT)
From: Thomas Molina <tmolina@home.com>
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: Doug McNaught <doug@wireboard.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Data-corruption bug in VIA chipsets
In-Reply-To: <Pine.LNX.4.30.0104140727310.956-100000@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.30.0104151237370.24481-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Dan Podeanu wrote:

> On 13 Apr 2001, Doug McNaught wrote:
>
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >
> > > > Here might be one of the resons for the trouble with VIA chipsets:
> > > >
> > > > http://www.theregister.co.uk/content/3/18267.html
> > > >
> > > > Some DMA error corrupting data, sounds like a really nasty bug. The
> > > > information is minimal on that page.
> > >
> > > What annoys me is that we've known about the problem for _ages_. If you look
> > > the 2.4 kernel has experimental workarounds for this problem. VIA never once
> > > even returned an email to say 'we are looking into this'. Instead people sat
> > > there flashing multiple BIOS images and seeing what made the difference.
> >
> > Is this problem likely to affect 2.2.X?  I have a VIA-based board on
> > order (Tyan Trinity) and I don't plan to run 2.4 on it anytime soon
> > (it's upgrading a stock RH6.2 box).
> >
>
> We've had HUGE problems with 2.4.x kernels and VIA based boards. We have
> here 3 VIA boards with Athlon/850 and Duron/900 CPUs. The problem goes
> like this:
>
> Compile 2.4.3 with VIA and Athlon support.
> Reboot.
> Ooopses (between 1 and continuously scrolling of them) occur at random
> periods of time, between mounting the root filesystem and 2-3 minutes of
> functionality.
>

Interesting.  I have an ASUS A7V board I'm running an Athlon 900 on with
none of the problems noted here.  Are there specific hardware
correlations that people have noted?  It does have the 686B southbridge
noted in the article as causing problems.

The BIOS thing is interesting though.  I work part time in a computer
repair shop.  With the A7V boards you never know which BIOS version will
be on the board.  The A7V is one of the most popular ones we have for
AMD chips.  We sell a ton of them, so if there are problems I'd sure
like to be kept up to date.

