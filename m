Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSE1PpQ>; Tue, 28 May 2002 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSE1PpP>; Tue, 28 May 2002 11:45:15 -0400
Received: from mark.mielke.cc ([216.209.85.42]:7179 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316827AbSE1PpO>;
	Tue, 28 May 2002 11:45:14 -0400
Date: Tue, 28 May 2002 11:39:38 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Karim Yaghmour <karim@opersys.com>
Cc: yodaiken@fsmlabs.com, linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
Message-ID: <20020528113938.B17353@mark.mielke.cc>
In-Reply-To: <57.c083d0f.2a237c49@aol.com> <20020527123643.9297A11973@denx.denx.de> <20020528060406.A18344@hq.fsmlabs.com> <3CF3A009.E7320E98@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 11:19:37AM -0400, Karim Yaghmour wrote:
> Thanks Victor for taking the time to go through some of the issues.

> yodaiken@fsmlabs.com wrote:
> > 1. MYTH: "The acceptance of Linux in embedded is being harmed by
> >     uncertainty over intellectual property"
> That is your own assesment, which is of course somewhat biased since I
> don't see you coming out and telling us: "True, the market has a problem
> with my patent." This standpoint is the only one expected. But given
> that you are not the only vendor out there, others have testified on this
> list that indeed Linux has a hard time penetrating in the embedded/rt
> market precisely because of your patent.

Sounds like people who can't get customers calling foul to the one
that can.

> I will leave it to the average LKML reader to decide whether the problems
> I discribe are "myth" of "fact" in light of all the testimony presented on
> this list.

I would label it "seriously exaggerated fact to obtain market share".

> Also, you omit to explain why the 11,000 developers sampled by the VDC
> point "real-time limitations" as their #1 show-stopper for using Linux.

"Real-time limitations" *are* the #1 show-stopper for using Linux. This
isn't an argument for or against your point.

> > And most of embedded Linux use does not require hard real-time.
> You're trying to play the "niche" trick here, pointing out that your
> patent is OK because it's a niche market. As I pointed out very
> early in this thread, embedded/rt is far from being a niche.

Actually, it looked like he was just presenting a fact. Most people that
say they need RT, don't, and the few that do, do not tend to mind patents.

> > 2. MYTH "The patent license is a terrible burden and terribly vague".
> FSMLabs cannot be compared in any way to any other open source company:
> I can rewrite Qt and distribute it under the license I like
> I can rewrite MySQL and distribute it under the license I like
> I can't rewrite RTLinux and distribute it under the license I like
> As for your dismissal of the "motivation behind the act", it does not
> dismiss any of our arguments, but only reinforces them.

Most companies with serious RT requirements do not wish to re-write
and distribute 'as they like'. In fact, the only reason they have to
do this now, is because the tools are not mature enough.

The problem here is obviously open-source companies that prefer to
avoid paying for software, because they do not sell software, and
companies that sell software, and do not mind paying for software to
sell software.

The fact is, patents are legal. Live with it, or convince a few
senators that they should remove 'patent infringement' from the set of
actions that can be tried in a court of law.

You are not getting anywhere here.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

