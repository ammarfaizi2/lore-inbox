Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313714AbSDHRtz>; Mon, 8 Apr 2002 13:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSDHRty>; Mon, 8 Apr 2002 13:49:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10814 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313714AbSDHRty>; Mon, 8 Apr 2002 13:49:54 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Brian Litzinger <brian@top.worldcontrol.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work better
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz>
	<20020408074729.GA1634@top.worldcontrol.com>
	<20020408101256.GE27999@atrey.karlin.mff.cuni.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Apr 2002 11:43:11 -0600
Message-ID: <m1k7rim6hc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > > There were two bugs, and linux/mm.h one took me *very* long to
> > > find... Well, those bits used for zone should have been marked. Plus I
> > > hack ide_..._suspend code not to panic, and it now seems to
> > > work. [Sorry, 2pm, have to get some sleep.]
> > 
> > I can suspend without oopses.  Yeh!
> > 
> > However, during the boot '2419p5a3 resume=/dev/hda6'  it oopses right
> > after saying a couple of things about not being able to determine
> > blocksize.  I'll photograph the repeatable oops and get it to you
> > when I have access to my camera again.  Probably in the next
> > 24 hours. 
> 
> I mailed two patches to the list in last two days. The first one
> should fix this.
> 
> > > (about SSSCA) "I don't say this lightly.  However, I really think that
> > > the U.S. no longer is classifiable as a democracy, but rather as a
> > > plutocracy." --hpa
> > 
> > The US was never a democracy.  It was a constitutional republic.
> 
> I think you can have democracy and constitutional republic at same
> time, no?

In a technical sense the difference is when a vote is taken to
pass/not pass a law.   In a republic your representative votes for
you.  In a democracy every citizen in the whole nation votes.

Eric

