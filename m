Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJHV25>; Tue, 8 Oct 2002 17:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJHV25>; Tue, 8 Oct 2002 17:28:57 -0400
Received: from pc132.utati.net ([216.143.22.132]:6306 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261715AbSJHV2t>; Tue, 8 Oct 2002 17:28:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Thomas Molina <tmolina@cox.net>
Subject: Re: The end of embedded Linux?
Date: Tue, 8 Oct 2002 12:34:17 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Gigi Duru <giduru@yahoo.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210080817420.1787-100000@dad.molina>
In-Reply-To: <Pine.LNX.4.44.0210080817420.1787-100000@dad.molina>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021008213416.3CC84544@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 09:22 am, Thomas Molina wrote:
> On Mon, 7 Oct 2002, Rob Landley wrote:
> > On Monday 07 October 2002 05:56 pm, Gigi Duru wrote:
> > > --- Rob Landley <landley@trommello.org> wrote:
> > > > The doorknob is a wonderful user interface...
> > >
> > > try driving your car using a doorknob ;)
> >
> > The steering wheel is fundamentally different?  (It's certainly
> > BIGGER...)
>
> Actually, I believe the wheel, and the rest of the user interface for an
> auto (gas pedal, brake) are a fine metaphor for this discussion.  The user
> interface for a car hasn't changed in how many years?  That is despite
> quite a number of technological devleopments under the hood.  Having a
> simple user interface for the "novice" doesn't prevent all kinds of weird
> shifting, throttle control, etc. additions for the "expert".  Having a
> single doorknob which controls, in a gross way, the action of a large
> number of "sub-knobs" is good.  Giving access to the "sub-knobs" for the
> expert is even better.

And extending the metaphor, even racecar drivers use a steering wheel and gas 
pedal.  (They almost always prefer manual transmission over auto, and like to 
have a tachometer in their display, but those are options for regular drivers 
in normal cars too.)

There are 8 zillion strange adjustable things in a racecar, but that's for 
the pit crew to deal with, not the driver.

The linux kernel is the same.  Going into the source is definitely something 
the pit crew is responsible for, or your friendly neighborhood garage 
mechanic, or the guy who likes to change his own oil on the weekends.

"make menuconfig" isn't anywhere near steering wheel simplicity, but the last 
time we had this discussion "aunt tillie" wandered through, which effectively 
ended rational debate if you ask me.  (She's like that, I suppose. :)  Still, 
cluttering it up any more than strictly necessary probably isn't a good thing.

90% of learning to deal with the linux kernel is learning to separate out the 
stuff you're interested in from the bits you can safely ignore at the moment, 
so you can tackle things one piece at a time.  (For some value of "safely", 
anyway... :)

Rob
