Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTBOSCY>; Sat, 15 Feb 2003 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTBOSCY>; Sat, 15 Feb 2003 13:02:24 -0500
Received: from bitmover.com ([192.132.92.2]:52171 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264706AbTBOSCW>;
	Sat, 15 Feb 2003 13:02:22 -0500
Date: Sat, 15 Feb 2003 10:12:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030215181211.GA12315@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nicolas Pitre <nico@cam.org>, Larry McVoy <lm@bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030214235724.GA24139@work.bitmover.com> <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of this sounds great and is exactly what is already the plan.
There is one missing item.  A consensus in the community that if we
provide BK, the CVS mirror, bkbits hosting, in return the community
agrees to leave off using BK to copy BK.

If what is being asked of us is more free service and engineering and
we are getting nothing in return, that's a non-starter.

So we'll wait to see what the community says.  In this particular
instance, the open source community has a choice.  We've granted people
the free use of our tools, unlike any other company.  If the response
is going to be "hey, cool, now it's even easier to copy these tools"
then (a) we're idiots and (b) we're not going to follow that up with
more free services.

Make up your mind as to what you want as a community and let me know.
I know what you want is a GPLed BK.  That's not on the table.  You don't
have one and you can't produce one any time soon, it would take years,
ask the Subversion guys or the arch guys or anyone you like, this isn't a
matter of some perl scripts and a weekend hack.  So until someone produces
a viable alternative, you can have or not have BK to use, depending on
your behaviour.  I'd love to reach a compromise which leaves all parties
happy.  You want free access to the data in real time, I want you to
leave us a chance to grow our business.  If you want to have access to
the data in CVS and you want to be free to go clone BK and you want to
be free to go use BK without charge, that's asking way too much.

One answer, maybe the only viable answer, is to use patents to protect
our technology.  To date we've been very sparing in where we have done
that, there are substantial chunks of BK without patent protection.  Some
leaders in the kernel group have privately told me to not ship BK without
patent protection.  That slows down how fast you get a better BK, it's not
something we can just wave our hands and make be so, it's lots of time and
money.  A single patent costs more than enough bandwidth to keep all of 
you happy for a year.  Whatever.  If you guys can't come to some sort
of consensus, then patents are the route we'll choose, even German law
respects patents.


On Sat, Feb 15, 2003 at 12:44:34PM -0500, Nicolas Pitre wrote:
> On Fri, 14 Feb 2003, Larry McVoy wrote:
> 
> > As with many things in life, you can choose to behave well or poorly and
> > the people you help or hurt will act according.
> 
> Larry,
> 
> Aren't you tired of all this shit people are making of BK?
> 
> You will always have people bitching at you just like people are bitching at
> Microsoft Word, whether those people are morons or great hackers is
> irrelevant.
> 
> Be smart and put a Linux CVS repository on bkbits.net even if it costs you
> some bandwidth money at first, oh and have the CVS repo to be always in sync
> with the bk repo of course.  This way you'll be able to tune the process,
> make sure it can be fully automated, then everybody will be happy and you'll
> sleep in peace for a while.
> 
> Then, to handle the bandwidth/money issue, you just need to put bandwidth
> limiting on the CVS port (Linux can do that so well - just ask for help if
> you can't achieve it) and issue a call for mirror sites where bkbits.net
> could commit CVS changes to.  Right now BitKeeper might have solved the
> Linux development process scalability issue (from the community toward
> Linus), but for the process to be perfect you also need to address the
> opposite path i.e. the broadcasting of changes that Linus applied toward
> the community, and this has to happen in real time as well.
> 
> We can agree that BitKeeper is so superior to CVS just like M$ Word format
> is way more powerful than plain text [1].  The reality is that plain text
> files are just so portable and universally readable that they are preferable
> to the Word format, even if M$ is giving Word viewers away for free.
> 
> You can't change the Free Software world that you are so faithfully trying
> to help.  You still can make them happy, and for that a real-time gateway
> from the Linux bk to CVS repos is the only way for the present time.  CVS is
> still the lowest common denominator SCM among this world and you can't 
> ignore it for broadcasting changes back to the community.
> 
> 
> Nicolas
> 
> 
> [1] this doesn't mean that I personally endorse M$ Word in any way.

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
