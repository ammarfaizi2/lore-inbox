Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268213AbTALDgo>; Sat, 11 Jan 2003 22:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268214AbTALDgn>; Sat, 11 Jan 2003 22:36:43 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:22954 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268213AbTALDgk>; Sat, 11 Jan 2003 22:36:40 -0500
Date: Sat, 11 Jan 2003 22:43:29 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-reply-to: <20030112033325.GA14644@mark.mielke.cc>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042343009.1033.142.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com>
 <1042250324.1278.18.camel@RobsPC.RobertWilkens.com>
 <20030111020738.GC9373@work.bitmover.com>
 <1042251202.1259.28.camel@RobsPC.RobertWilkens.com>
 <20030111021741.GF9373@work.bitmover.com>
 <1042252717.1259.51.camel@RobsPC.RobertWilkens.com>
 <20030111214437.GD9153@nbkurt.casa-etp.nl>
 <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
 <20030111222619.GG9153@nbkurt.casa-etp.nl>
 <1042327403.1033.71.camel@RobsPC.RobertWilkens.com>
 <20030112033325.GA14644@mark.mielke.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 22:33, Mark Mielke wrote:
> On Sat, Jan 11, 2003 at 06:23:23PM -0500, Rob Wilkens wrote:
> > On Sat, 2003-01-11 at 17:26, Kurt Garloff wrote:
> > > It is presumptuous. Very much so.
> > I'll accept that on face value, and take your comments five comments as
> > good pieces of information which I'll comment only briefly on.
> 
> Also take into account that your claim to faim -- vxWorks, a real time
> commercial operating system, may not of the same calibre as Linux.

I never mentioned VxWorks (This is bad, someone is actually keeping
track and researching my background).  But that was a product at a
company I used to work for.. Joe Korty (whom I saw just submitted a
patch from a machine I used to have an account on) who works for that
company can probably tell you more about VxWorks than I can.  Hopefully
he doesn't remember me.

VxWorks, or PowerMAX or PowerUX or whatever they're calling it now
(names changed several times while I worked there) was basically AT&T
SVR4, with some custom enhancements.

> Why do I doubt the calibre of vxWorks? People I trust who work on RT systems

The company probably went downhill after I left in 1998 :-).  I was
releasing (personally) at least 7-10 modifications to the kernel a week
on average.  Joe Korty was probably the only other developer there who
was almost as productive at the time.  The rest of their team were a
bunch of very knowledgeable yet "comfortable" people who looked like
they were basically happy to rest on their laurels (they had fast
performing hardware, and they had exclusive knowledge of the software,
so they didn't "have" to work harder).  There were of course several
contractors there who were productive, but anyone working on a contract
is going to be more productive than a salaried person for the sole
reason that they _have_ to prove their worth.

Yep, If there is anyone reading this list whom I ever hoped to use as a
personal reference in the future, I probably just ruled that out :-).  I
figure as long as the career is in the toilet, might as well flush.

> For your suggestion that writing an operating system is not hard -- I
> agree with your chosen qualification of 'a'. Most anybody who passes
> 1st year in CS at university can complete 'a' DOS-like operating
> system.

Thank You, that was my only point.  Of course, I would say 3rd or 4th
year -- at least in a U.S. university.  As per whether "anybody" could
take it to the next level, that is just an elitist viewpoint you have
which you are free to keep.  When you think of what is involved in, for
example, memory management, it's not all that complicated.  I downloaded
the document that Mel Gorman wrote (a thesis, it claims) and while it's
nice, so far I've read the first 14 pages of the text and haven't even
seen anything about the VMM -- it's all been about what a tar is, how
big the kernel has grown, why CVS isn't used (which is interesting to
read), but nothing yet about the virtual memory manager which is what I
picked up the document for.  I guess for free one can't complain.

> Also, FYI, most of the patches that I see coming through here are patches
> to *other* people's code, usually code that has not existed more than a
> few months. Which doesn't mean that Linus' code is flawless.

Can you explain, then, why I submitted a patch to the floppy driver
minutes ago :-).  You would think that's the kind of thing they would've
gotten working long ago.  Of course, I don't know enough to get a floppy
drive working at all, so I'm duly impressed with that basic ability.

> Just -- evolution has a price. 

Actually, you can download it free at www.ximian.com .. They may sell it
to you on CD for a price, though.  It's what I'm using to write this
e-mail.

-Rob

