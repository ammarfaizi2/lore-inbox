Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281569AbRKMJyU>; Tue, 13 Nov 2001 04:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281572AbRKMJyK>; Tue, 13 Nov 2001 04:54:10 -0500
Received: from [195.63.194.11] ([195.63.194.11]:3851 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S281569AbRKMJxv>;
	Tue, 13 Nov 2001 04:53:51 -0500
Message-ID: <3BF0FA09.682BE623@evision-ventures.com>
Date: Tue, 13 Nov 2001 11:46:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
		<Pine.GSO.4.21.0111122300290.22925-100000@weyl.math.psu.edu> <200111130421.fAD4LbZ17072@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Alexander Viro writes:
> > On Mon, 12 Nov 2001, Richard Gooch wrote:
> > > Alexander Viro writes:
> > > > On Mon, 12 Nov 2001, Richard Gooch wrote:
> > > > > Dave Jones writes:
> > > > > > How about running mtrr.c & devfs code through scripts/Lindent
> > > > > > sometime btw?
> > > > >
> > > > > That would be a step backwards: I wouldn't be able to read my own code
> > > > > then.
> > > >
> > > > You mean that you are unable to read any of the core kernel source?
> > > > That would explain a lot...
> > >
> > > Were you born rude, or did you have to practice it?
> >
> > Excuse me?  You've just stated that you are unable to read the code
> > in style enforced by Lindent.  kernel/*.c, mm/*.c, fs/*.c and large
> > part of fs/*/*.c _are_ in that style.  I've asked you a perfectly
> > legitimate (and obvious) question: "does it imply what it seems to
> > imply?"  What's rude about that?
> 
> Are you being deliberately obtuse? Your "that would explain a lot"
> comment is an obvious insult.

The insult is adequate to the coding style in question.
And they are right: multi statement lines and such is really crap.

> Al, I'm really tired of your snide comments. You've been hostile and
> making personal attacks for years now. You've been rude and insulting
> to other people on this list as well. Even if you don't care how
> childish it appears, just save us all the bandwidth. We don't want to
> play that game with you.

Speak for yourself. I enyoj the comments for one.

> And I don't care to discuss this further. I know what your two
> possible reactions are:
> - you're not being rude (uh, yeah, right)
> - it doesn't matter as long as your technical points are correct (I'm
>   just quoting you there) (BTW: you're not infallible either).

Just the frequency is somehow lower...
