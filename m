Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314361AbSDVSBD>; Mon, 22 Apr 2002 14:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314376AbSDVSBC>; Mon, 22 Apr 2002 14:01:02 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:54141 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314361AbSDVSAx>; Mon, 22 Apr 2002 14:00:53 -0400
Message-Id: <5.1.0.14.2.20020422184538.03ce36e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Apr 2002 19:01:39 +0100
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16zKy9-0001Hw-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:17 21/04/02, Daniel Phillips wrote:
>On Monday 22 April 2002 19:10, Jeff Garzik wrote:
> > On Sun, Apr 21, 2002 at 05:50:25PM +0200, Daniel Phillips wrote:
> > > On Monday 22 April 2002 17:44, Larry McVoy wrote:
> > > > On Sun, Apr 21, 2002 at 02:53:13PM +0200, Daniel Phillips wrote:
> > > > > I hope I made it clear that I believe BK is helping 
> Linux.  Furthermore, I
> > > > > don't see why Larry should not collect some advertising for his 
> contribution.
> > > > > Within limits.  IMHO, we're on the wrong side of the limit at the 
> moment,
> > > > > and moving further with no sign of moderating.
> > > >
> > > > Yes, because so many purchasing managers spend their time reading the
> > > > Documentation subdirectory of the Linux kernel in order to decide what
> > > > SCM system they should use.
> > > >
> > > > The existence (or non-existence) of the docs has absolutely no 
> marketing
> > > > value to BK.
> > >
> > > So you have no problem with moving them to a website, leaving a url in
> > > SubmittingPatches?
> >
> > Do you have a problem with moving other docs out to Websites, which are
> > describing closed-spec hardware?  Such hardware (and their vendors) are
> > actively anti-open source, yet we have documents describing those, too.
>
>The other example specifically mentioned was the CVS documentation for jfs,
>and yes, I think that moving those instructions to the web site in question
>would make a lot of sense, leaving a URL wherever the docs once were.  By
>definition, the CVS instructions will be available on that site as long as
>they are useful, and not a moment longer.

Personally I find it _extremely_ annoying having to go and lookup web sites 
which the kernel points me to instead of just having the docs in the kernel 
in the first place.

For source code to additional utilities, ok, fair enough, we can't have 
everything in the tree but for documentation, which is a pre-requisite or 
at least a help to understanding something about the kernel, I don't see 
why people have to just be referred out of the tree.

Especially because I only need to look up some URL just when I have no 
internet access for a week or two (and hence have the time to look things 
up)... Having documentation on some random web site is not going to help 
there at all. And guess what? I learned how to use bitkeeper when I was on 
holiday for two weeks. And guess also what? It was Jeff's document which 
was my main guide on how to do it in combination with the bk kernel tree. I 
would have been well pissed off if I had found that I needed to get the 
document off the web after I had gone away...

As a complete different, general point, the probability of documentation 
being updated when it is outside the tree is _much_ lower than when it is 
inside the tree. Admittedly the bitkeeper document itself is unlikely to 
change over time but the scripts helping submissions which are in the same 
place as the document may very well change over time.

I would much rather see a disclaimer put in Jeff's document stating that 
"you don't need to use it, gnu patches are just fine with everyone, etc" as 
others have already suggested.

If such disclaimer doesn't appease the anti-bitkeeper crew then moving the 
document out won't either, so moving it out would be a waste of time in 
addition to penalizing people who want to use bitkeeper, which is unfair 
and incorrect.

Finally, if you object to this _that_ much, why not fork the tree remove 
the document, and live happy ever after? Perhaps all the anti-bk people 
will follow you... (-;

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

