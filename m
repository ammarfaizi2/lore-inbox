Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317411AbSFCQLn>; Mon, 3 Jun 2002 12:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317412AbSFCQLm>; Mon, 3 Jun 2002 12:11:42 -0400
Received: from mark.mielke.cc ([216.209.85.42]:3602 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317411AbSFCQLl>;
	Mon, 3 Jun 2002 12:11:41 -0400
Date: Mon, 3 Jun 2002 12:05:54 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: If you want kbuild 2.5, tell Linus
Message-ID: <20020603120554.A29569@mark.mielke.cc>
In-Reply-To: <86256BCD.0055567F.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 10:29:10AM -0500, Wayne.Brown@altec.com wrote:
> Keith Owens <kaos@ocs.com.au> wrote:
> >It is a sad day when a fully tested and documented system that is
> >faster and, above all, more accurate, cannot get into the kernel.
> >Linus is judging kbuild 2.5 on its popularity and on personalities, not
> >on its technical merits.
> Right, make Linus do what you want by impugning his technical
> judgment, calling him a liar, and asking people to flood his mailbox
> with complaints.  Sure, THAT will work.

It is still unfortunate that all contributions, especially larger scale
ones, cannot be openly accepted and embraced. It isn't as if the change
is overly invasive... if both system can operate in parallel, the impact
is significantly less.

Alas, we have these things called precidents and processes that attempt to
hone the quality of releases at the cost of potential productivity.

Keith: I do not think Linus is discouraging kbuild 2.5 due to popularity
or personalities. I suspect he is discouraging it due to a healthy fear
of the precident that it would set, as well as the chance that it would
require a great deal more work and you and your collaborators all get hit
by a bus ( or get a life? :-) ) tomorrow morning.

I'm not certain where the line is for 'breaking the change up', such that
the effort does not become substantially more, but the requirement for the
line has been decreed.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

