Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbRLaIpQ>; Mon, 31 Dec 2001 03:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287467AbRLaIpH>; Mon, 31 Dec 2001 03:45:07 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:15119 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287441AbRLaIo4>;
	Mon, 31 Dec 2001 03:44:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: The direction linux is taking
Date: Mon, 31 Dec 2001 09:45:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <20011229160334.A9919@redhat.com> <20011229140410.A13883@work.bitmover.com>
In-Reply-To: <20011229140410.A13883@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ky48-0003hT-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 29, 2001 11:04 pm, Larry McVoy wrote:
> On Sat, Dec 29, 2001 at 04:03:34PM -0500, Benjamin LaHaise wrote:
> > On Sat, Dec 29, 2001 at 11:37:49AM -0800, Larry McVoy wrote:
> > > If you have N people trying to patch the same file, you'll require N
> > > releases and some poor shlep is going to have to resubmit their patch
> > > N-1 times before it gets in.
> > 
> > Wrong.  Most patches are independant, and even touch different functions. 
 
> 
> Really?  And the data which shows this absolute statement to be true is
> where?  I'm happy to believe data, but there is no data here.

Ben's right.  Most patches are independant because the work divides itself up 
that way, because people talk about this stuff (on IRC) and cooperate, and 
because the tree structure evolves to support the natural divisions ;)

--
Daniel
