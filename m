Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbSJGB6b>; Sun, 6 Oct 2002 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSJGB6b>; Sun, 6 Oct 2002 21:58:31 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:63506
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262342AbSJGB63>; Sun, 6 Oct 2002 21:58:29 -0400
Date: Sun, 6 Oct 2002 19:01:31 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gigi Duru <giduru@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021006202032.52214.qmail@web13202.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10210061850570.23945-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Gigi Duru wrote:

> We obviously have a very different perception of the
> term "hacker". I wonder if anyone here shares yours...

Well the obvious goal is to promote addressing the true talent in the list
of developers and contributors as something better than a "hacker".  Sure
most joke in context within the community, but outside all deserve the
respect of a quality "developer" on one scale or another.

> It was not my intention to offend anyone, but to get
> your attention on what seems to be a forgotten detail:
> kernel size. 

Remember the ramping up of features in the beginning is always followed by
a slash and burn near the close.

> It has nothing to do with who I am or what platform am
> I working on or those annoying emails nagging you. It
> is about making Linux better. "Better" may have
> different meanings for different people. For most
> "faster" is the closest. You optimize for speed.
> Adding a second criterion (size) would only increase
> the value of the code. 

In the case of current IDE, we bloated to standardize callers and once
they were comman to all HBA's they were condensed to a single export
function (de-bloat).  Then we bloated some more to allow for modular
chipsets, the end result may be more bulk if everything is compiled into
the kernel, but now the option to deflate the basic kernel and load
modules is on the threshold.

> Keep up the good work, and your ego down,
> Gigi

EGO where, that was blown out the sky at the beginning of 2.5 during the
foot in acehole process, Linus performed on me as the door whopped me in
the backside.

The object is to get you to stop complaining and start doing.
If you put as much effort into coding as wasted in replies, I be you could
be done?

The water is warm, just watch out for fins! :-)

Cheers,

Andre Hedrick
LAD Storage Consulting Group


> --- Andre Hedrick <andre@linux-ide.org> wrote:
> > 
> > Well given that I get emails for "embedded" space
> > nagging me about
> > supporting their stuff yet they will not reveal the
> > alterations to the GPL
> > code they borrowed, and moan when the discuss of
> > paying for consulting on
> > opensource they have illegally closed.  Yeah, I have
> > zero compasion for
> > the embedded folks.
> > 
> > Gee every considered embedding somthing with a
> > little horsepower?
> > 
> > So again, if you want change?  Submit it.
> > If you want a consultant?  Pay for it.
> > 
> > Next running around calling people "hackers" is not
> > the best way to win
> > friends.  Do you think you could sell your embedded
> > cruft if you told your
> > customer base, "Gee, I am just a hacker.  Please buy
> > my product."
> > 
> > Dead thread for me now.
> > 
> > Cheers,
> > Andre Hedrick
> > LAD Storage Consulting Group
> > 
> 
> __________________________________________________
> Do you Yahoo!?
> Faith Hill - Exclusive Performances, Videos & More
> http://faith.yahoo.com
> 

