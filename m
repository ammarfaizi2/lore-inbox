Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290810AbSAaBYI>; Wed, 30 Jan 2002 20:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSAaBYA>; Wed, 30 Jan 2002 20:24:00 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:59799 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290811AbSAaBVq>;
	Wed, 30 Jan 2002 20:21:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stuart Young <sgy@amc.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Wanted: Volunteer to code a Patchbot
Date: Thu, 31 Jan 2002 02:26:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>,
        Rasmus Andersen <rasmus@jaquet.dk>, killeri@iki.fi,
        patchbot-devel@killeri.net
In-Reply-To: <20020130162851.H9765@jaquet.dk> <5.1.0.14.0.20020131114402.02653b10@mail.amc.localnet>
In-Reply-To: <5.1.0.14.0.20020131114402.02653b10@mail.amc.localnet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W5zM-0000Jl-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 31, 2002 01:49 am, Stuart Young wrote:
> At 04:46 PM 30/01/02 +0100, Daniel Phillips wrote:
> >On January 30, 2002 04:28 pm, Rasmus Andersen wrote:
> > > Somehow, I totally forgot the security disclaimer for some of
> > > the points. Obviously, mindlessly patching a makefile and
> > > executing it would be a Bad Idea. If no satisfying solution
> > > to this can be found, this (execute/compile) step could be
> > > foregone.
> > >
> > > Thanks to Tommy Faasen for raising this point.
> >
> >I'd say, don't try to run it, just see if it applies cleanly.
> >
> >Speaking of security, we can't expect Matti to take care of blocking spam
> >on the patch lists the way he does on lkml, so that is going to have to
> >be handled, or the system will fall apart.  Well, spammers are not going
> >to be bright enough to send correctly formed patches that apply without
> >rejects I hope, so maybe that is a non-problem.
> 
> Possibly, but then it'll reply to the spammer and you'll get bounces left 
> and right. Perhaps it's a simple case that the patcher submitting will have 
> to have registered the email address before submitting their patch. Only 
> needs to be done once (not every time a patch is submitted, that's mad!), 
> and weeds out the noise.

Yes, that's a point for discussion.  Certainly, a patchbot list like 
patches-2.5-maintainer should require registration, and in fact, registration 
for this list will be by invitation.  It's not so clear what the policy 
should be on the patches-2.5 list.  Openness is a nice thing to be able to 
boast about.  Maybe the thing to do is try it open, and see how it works out.

We also have to worry about malicious spamming of the patch list.  I've heard 
this happened to kuro5hin's story submission queue - there is no accounting 
for all the forms of insect life out there.

-- 
Daniel
