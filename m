Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSDVRrh>; Mon, 22 Apr 2002 13:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314341AbSDVRrg>; Mon, 22 Apr 2002 13:47:36 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:63174 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314340AbSDVRqv>;
	Mon, 22 Apr 2002 13:46:51 -0400
Date: Mon, 22 Apr 2002 13:46:48 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020422134648.C11216@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zKy9-0001Hw-00@starship> <20020422131942.A10714@havoc.gtf.org> <E16zLHY-0001IC-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:37:47PM +0200, Daniel Phillips wrote:
> On Monday 22 April 2002 19:19, Jeff Garzik wrote:
> > (Linus removed from CC)
> > 
> > On Sun, Apr 21, 2002 at 07:17:45PM +0200, Daniel Phillips wrote:
> > > On Monday 22 April 2002 19:10, Jeff Garzik wrote:
> > > > Do you have a problem with moving other docs out to Websites, which are
> > > > describing closed-spec hardware?  Such hardware (and their vendors) are
> > > > actively anti-open source, yet we have documents describing those, too.
> > > 
> > > The other example specifically mentioned was the CVS documentation for jfs,
> > > and yes, I think that moving those instructions to the web site in question
> > > would make a lot of sense, leaving a URL wherever the docs once were.  By
> > > definition, the CVS instructions will be available on that site as long as
> > > they are useful, and not a moment longer.
> > > 
> > > This is all irrespective of the fact that CVS does not have the problem of
> > > having a restrictive license, but since you asked...
> > 
> > Well, in order to prove you're being fair, your patch should have
> > included removal of those CVS instructions, too :)
> 
> Would it satisfy you (just talking about *you* now) if I ammended it so it did?
> This would be purely to satisfy you of course, since the license issue does not
> exist with CVS, and it would be contingent on negotiating a new home for the
> jfs CVS instructions.
> 
> > That's the point Linus made in his first message, and one I agree with.
> 
> You want it, you got it.  Deal?

You are misunderstanding me and Linus.

The point is that your patch was singling out BK unfairly,
and the mention of CVS was an _example_ of that.

I do not support the removal of the BK docs, nor the CVS docs.
Linus does not appear to, either.

In fact, if someone wrote a general doc describing productive kernel
development under CVS, I would support the addition of that.  (though
Linus may not, since it's not vaguely equivalent to SubmittingPatches)

	Jeff



