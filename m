Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285449AbRLSUGa>; Wed, 19 Dec 2001 15:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285438AbRLSUGZ>; Wed, 19 Dec 2001 15:06:25 -0500
Received: from dsl-213-023-043-155.arcor-ip.net ([213.23.43.155]:25356 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285440AbRLSUGP>;
	Wed, 19 Dec 2001 15:06:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: aio
Date: Wed, 19 Dec 2001 21:09:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com> <20011219135708.A12608@devserv.devel.redhat.com>
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Gn1i-0000V0-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 19, 2001 07:57 pm, Ben LaHaise wrote:
> On Wed, Dec 19, 2001 at 09:01:59AM -0800, Linus Torvalds wrote:
> > 
> > On Wed, 19 Dec 2001, Daniel Phillips wrote:
> > >
> > > It's AIO we're talking about, right?  AIO is interesting to quite a few
> > > people.  I'd read the thread.  I'd also read any background material 
> > > that Ben would be so kind as to supply.
> > 
> > Case closed.
> > 
> > Dan didn't even _know_ of the patches.
> 
> He doesn't read l-k apparently.

Dan Kegel put it succinctly:

   http://marc.theaimsgroup.com/?l=linux-aio&m=100879005201064&w=2

Your original patch is here, and I do remember the post at the time:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=98114243104171&w=2

This post provides *zero* context.  Ever since, I've been expecting to see 
some explanation of what the goals are, what the design principles are, what 
the historical context is, etc. etc., and that hasn't happened.

I've got a fairly recent version of the patch too, it's a little too long to 
just sit down and read, to reverse-engineer the above information.  What's 
missing here is some kind of writeup like Suparna did for Jens' bio patch 
(hint, hint).  There's no reason why every single person who might be 
interested should have to take the time to reverse-engineer the patch without 
context.

As Linus points out, the active discussion hasn't happened yet.

--
Daniel
