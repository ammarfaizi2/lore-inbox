Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbRL0Pql>; Thu, 27 Dec 2001 10:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbRL0Pqc>; Thu, 27 Dec 2001 10:46:32 -0500
Received: from [198.17.35.35] ([198.17.35.35]:52920 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S286311AbRL0Pq0>;
	Thu, 27 Dec 2001 10:46:26 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A36@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
Date: Thu, 27 Dec 2001 07:46:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 1. Are we satisfied with the source code control system ?

> > > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> > > a good job with source control.

> really ?
> Do you know what good source control is ? i doubt it.

why do you drop to personal insults?  are your arguments that weak?

i'm a perforce admin.  if you don't know what perforce is, you go
look it up.  i used to be a CVS admin.  i REALLY hope you know what
THAT is.  and i've used clearcase and even SCCS/RCS in the past.

my point wasn't that marcelo and linus and allan are source control
systems.  my point was that if you're looking for a properly source-
controlled project, THEN DON'T USE LINUX AND QUIT YOUR FUCKING WHINING.

(ok, that might be a bit harsh, but there have been quite a few
people here who think that the linux kernel should be maintained
in the same way as a closed source commercially run project. But
if it was, it wouldn't be _Linux_ any more.)

Linux is maintained by Linus (2.5), Allan (2.2), and Marcelo (2.4)
(and someone's doing 2.0 still, but i forget who :)
That's The Way It Is (tm) and trying to change that isn't going to
happen any time soon (nor, given the disparity between the
Linux Kernel and the Linux Distributions, should it be)

> >Not really. We do a passable job. Stuff gets dropped, lost,
> >deferred and forgotten, applied when it conflicts with other work
> >- much of this stuff that software wouldnt actually improve on over a
> >person

ahhh, so trying to tackle these problems would be a good idea.
For example, Marcelo's adoption of the "final -pre is (essentially)
unchanged when it becomes the formal release"

Q - Would CVS or Perforce or BitKeeper help fix these problems?
A - No, the problem is one of organization, not accountability

Maybe we should toss the original question and try to find ways
to solve the organizational problems instead?

> >Many kernel bug reports end up invisible to some of the developers.

> that is exactly my point.

so maybe we should make it clear (in the maintainers file, for example)
WHERE patches and bugs should be reported?

It sounds more like a reporting problem than a tracking problem : the
maintainers know which bugs have been fixed (or patches to fix the bugs
have been applied at least) so the only thing missing is that the
maintainers
have to know about the bugs.  I don't think that a bugzilla-type central
bug reporting tool will help that, because the maintainers who don't read
LKML won't pay attention to bugzilla either.

--
Dana Lacoste
Ottawa, Canada
