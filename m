Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288203AbSAHRjW>; Tue, 8 Jan 2002 12:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288197AbSAHRjM>; Tue, 8 Jan 2002 12:39:12 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:34061 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S288192AbSAHRjC>; Tue, 8 Jan 2002 12:39:02 -0500
Message-Id: <200201081738.g08Hcw125981@schroeder.cs.wisc.edu>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Nicholas Knight <nknight@pocketinet.com>
Subject: Re: Bounce from andre@linuxdiskcert.org
Date: Tue, 8 Jan 2002 11:36:14 -0600
X-Mailer: KMail [version 1.3.2]
Cc: =?iso-8859-1?q?G=E9rard=20Roudier?= <groudier@free.fr>,
        Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20011230122500.E859-100000@gerard> <WHITEvJ1xKjtgZe0J64000008b1@white.pocketinet.com> <20020108181224.M5235@khan.acc.umu.se>
In-Reply-To: <20020108181224.M5235@khan.acc.umu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2002 11:12 am, David Weinehall wrote:
> On Sun, Dec 30, 2001 at 06:59:22AM -0800, Nicholas Knight wrote:
> > On Sunday 30 December 2001 03:33 am, Gérard Roudier wrote:
> > > Hello Andre,
> > >
> > > I already said you that my replies get not accepted by your email
> > > agents.
> > >
> > > If you want to post to an open list then you want to accept messages
> > > from people subscribed to that list. Doing different is just
> > > impoliteness.
> >
> > Andre isn't the only one that does this. It seems many people enjoy
> > blocking people with access to only one smtp server. Esspecialy when
> > that server is on a very small, isolated ISP, or an ISP that people
> > just ASSUME is up to bad things.
> >
> > David Weinehall sent me a private email recently, to which I responded,
> > but didn't go through because, oh wonder of wonders, the pocketinet
> > smtp server is listed on A spam list, and an apparent alias,
> > white.pocketinet.com, is on two.
> >
> > Now, aren't all these spam lists supposed to try and CONTACT the
> > providers to get the issue resolved before blacklisting them? I know
> > for a fact that if someone had actually contacted pocketinet about the
> > problem customer that sent spam, they would have taken care of it
> > promptly. It's a very small ISP in a remote area of Washington State,
> > and it's run by friendly and competent people.

Unfortunately, no, that's not how they (the black-list maintainers) operate.  

Speaking from experience, you get an email informing you that you're already 
on the blacklist.  Note, also, that being on the blacklist doesn't imply that 
you're actually sending span or are being used to send spam, either.  You can 
get black listed for allowing "open relaying", meaning that your sendmail 
will relay from outside to outside, basically.  The impotus is on you, the 
administrator, to resolve the problem *and* prove to them that it's been 
solved.  Mind you, this was several years ago, but I doubt that it's changed 
significantly.

It sure would be nice if they'd send you an email informing you that your 
site has an open relay, and if it's not corrected within, say, 1 week, you'll 
be put on the black list.  These sites also obviously have tests for checking 
for open relays, also.  The administrator of said site should be allowed 
access to these same tests to aid in diagnosing and solving the problem.

Sorry about the rant.  I appreciate what the black-listers are trying to do, 
but I think that their method sucks.

-Nick
