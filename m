Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSHLIV5>; Mon, 12 Aug 2002 04:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSHLIV5>; Mon, 12 Aug 2002 04:21:57 -0400
Received: from dsl-213-023-043-075.arcor-ip.net ([213.23.43.75]:26023 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317525AbSHLIVy>;
	Mon, 12 Aug 2002 04:21:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: large page patch (fwd) (fwd)
Date: Mon, 12 Aug 2002 10:22:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <1029113179.16236.101.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44L.0208112041110.23404-100000@imladris.surriel.com> <20020811165003.F17310@work.bitmover.com>
In-Reply-To: <20020811165003.F17310@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17eAT4-0001n3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 01:50, Larry McVoy wrote:
> On Sun, Aug 11, 2002 at 08:42:16PM -0300, Rik van Riel wrote:
> > On 12 Aug 2002, Alan Cox wrote:
> > 
> > > Unfortunately the USA forces people to deal with this crap. I'd hope SGI
> > > would be decent enough to explicitly state they will license this stuff
> > > freely for GPL use
> > 
> > I seem to remember Apple having a clause for this in
> > their Darwin sources, forbidding people who contribute
> > code from suing them about patent violations due to
> > the code they themselves contributed.
> 
> IBM has a fantastic clause in their open source license.  The license grants
> you various rights to use, etc., and then goes on to say something in 
> the termination section (I think) along the lines of 
> 
> 	In the event that You or your affiliates instigate patent, trademark,
> 	and/or any other intellectual property suits, this license terminates
> 	as of the filing date of said suit[s].
> 
> You get the idea.  It's basically "screw me, OK, then screw you too" language.

Yes.  I would like to add my current rmap optimization work, if it is worthy
for the usual reasons, to the kernel under a DPL license which is in every
respect the GPL, except that it adds one additional restriction along the
lines:

  "If you enforce a patent against a user of this code, or you have a
   beneficial relationship with someone who does, then your licence to
   use or distribute this code is automatically terminated"

with more language to extend the protection to the aggregate work, and to
specify that we are talking about enforcement of patents concerned with any
part of the aggregate work.  Would something like that fly?

In other words, use copyright law as a lever against patent law.

This would tend to provide protection against 'our friends', who on the one
hand, depend on Linux in their businesses, and on the other hand, do seem to
be holding large portfolios of equivalently stupid patents.

As far as protection against those who would have no intention or need to use
the aggregate work anyway, that's an entirely separate question.  Frankly, I
enjoy the sport of undermining a patent much more when it is held by someone
who is not a friend.

-- 
Daniel
