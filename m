Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283927AbRLAEuy>; Fri, 30 Nov 2001 23:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283935AbRLAEuv>; Fri, 30 Nov 2001 23:50:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62358 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283926AbRLAEue>;
	Fri, 30 Nov 2001 23:50:34 -0500
Date: Fri, 30 Nov 2001 20:12:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Henning Schmiedehausen <hps@intermeta.de>, Larry McVoy <lm@bitmover.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130201235.A489@mikef-linux.matchmail.com>
Mail-Followup-To: Henning Schmiedehausen <hps@intermeta.de>,
	Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <1007140529.6655.37.camel@forge> <20011130092730.Q14710@work.bitmover.com> <1007142785.6655.39.camel@forge> <20011130100729.R14710@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130100729.R14710@work.bitmover.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 10:07:29AM -0800, Larry McVoy wrote:
> Henning, perhaps you can explain to me how the following isn't a 
> 
> 	"I don't do XYZ"
> 
> 	"XYZ"
> 
> statement?
> 
> On Fri, Nov 30, 2001 at 06:53:05PM +0100, Henning Schmiedehausen wrote:
> > You may want to know that I work in this
> > industry for about 15 years and write commercial code (that is "code
> > that ships") since about that time (and I don't run around telling
> > everybody each and every time about it and what I've already done). 
> 
> That would be the "I don't do XYZ..."
> 
> > I've
> > written code in a good two dozen languages (including things that really
> > deserve to die like Comal) and I've worked in projects from "one man
> > show" to "lots of people in Elbonia also work on this".
> 
> And this would be the "XYZ".
> 
> If you are going to yell at people for a particular behaviour, it's really
> more effective if you don't show that behaviour in the midst of your yelling,
> wouldn't you agree?  Just a friendly thought.
>

He's basically complaining that you like to point out what you have done in
the past a lot.  Then goes to say that he has qualifications to prove that
his opinion should be listened to.

Not that I've been reading lkml long enough to notice...

> > So, please, please, Larry, _STOP THE FUCK PATRONIZING OTHERS_.
> 
> It would appear that you find everything I say patronizing, regardless of
> what it is or how it is said.  I'm sorry about that, but I'm not going
> to change how I speak to suit you.  Yell all you want.  I'd suggest
> that if you find my emails offensive, you add me to your kill file.
>

I don't know about you, but I wouldn't want to be in anyone's killfile.

> > The question now is, what is "amateur behaviour": Forcing this driver
> > writer to change or to tolerate his style in his driver? We're still
> > talking about a driver, not about the VM subsystem or the networking
> > core.
> 
> Your approach to this whole topic is a good example of why I run my own
> company and I have absolute authority to fire people at will.  If you 
> worked here and you persisted with this approach, you would be fired,
> without question.  I don't know how to say it more clearly, I don't
> say it lightly, hiring someone, training them, all of that is a huge
> investment.  One which I would discard if you couldn't fit in.  Coding
> style is part of fitting in, it isn't optional in any code I pay for.
>

Key words: "pay for".

This is Linux-Kernel.  Each developer is on their own on how they pay the
their bills.  The question is... Why not accept a *driver* that *works* but
the source doesn't look so good?  Maintainability? Yes.  Take the code, and
encourage better code.  Or even convert said initial submission to the
kernel style.

What really needs to happen...

Accept the driver, but also accept future submissions that *only* clean up
the comments.  It has been said that patches with comments and without code
have been notoriously droped.

mf
