Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSG2T46>; Mon, 29 Jul 2002 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSG2T46>; Mon, 29 Jul 2002 15:56:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41049 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317619AbSG2T4u>; Mon, 29 Jul 2002 15:56:50 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Alexander Viro <viro@math.psu.edu>, Federico Ferreres <fferreres@ojf.com>,
       Daniel Mose <imcol@unicyclist.com>, Larry McVoy <lm@work.bitmover.com>,
       Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, openpatentfunds@home.se
Subject: Re: Funding GPL projects or funding the GPL?
References: <Pine.GSO.4.21.0207280601260.27010-100000@weyl.math.psu.edu>
	<3D44F136.8060202@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2002 13:47:51 -0600
In-Reply-To: <3D44F136.8060202@namesys.com>
Message-ID: <m165yygvtk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Alexander Viro wrote:
> 
> >On 28 Jul 2002, Federico Ferreres wrote:
> >
> >
> >>I stated a simple idea aimed at solving a real world issue. And you
> >>haven't proved it wrong. It may not be what you or the kernel hackers
> >>need/want (which is FINE). But it would solve ALL the funding problems
> >>at least.
> >>
> >
> >You don't get it.  So far the only guy who had been charitable was Larry, who
> >felt that problem was real but had serious doubts about viability of your
> >idea.  I don't feel charitable and I've no reason to hesitate telling that
> >you guys _are_ waste of time.  No maybes about it.  It's that simple...
> >
> >
> >
> Viro is abusive to everyone (by email, he is likable in person oddly enough),
> usually without understanding what he is talking about at a level of depth any
> deeper than it is new therefor wrong (see devfs thread where he rejects devfs on
> 
> the basis of endless details without understanding that the basic idea had any
> merit).

There are a couple of interesting points raised in this thread.  
1) That a substantial part of the work of software is not building it, but
   is maintaining it.
2) That several people feel that it is hard to make a business plan with
   open source software.
3) Many successful software companies, have made money with a hardware tax.
   And open source could feasibly get part of that action, all you have to do
   is to demand that Linux be pre-installed.  And the distributions should
   get involved to help the hardware manufacturers.
4) Raising money is conceptually very simple.  But practically hard.
5) How society perceives the solution is a very important part of any solution.

A lot of economics is modeling and finding a system where the greedy
algorithm, can be used to optimize the system.  As all decisions are local
with the greedy algorithm it scales very well.  Most forms of central
planning, distribution whatever fall down because they are not built
on algorithms that scale.

The basic economic model of supply and demand with competition works
fairly well.  But it has problems when you have either an external
cost (Pollution) or an external benefit (Free Software).  With some
small amount of government regulation it is theoretically possible to
introduce these external costs, into the direct costs normally dealt
with.  The best scheme I have seen proposed is to sell permits to
pollute, with the maximum number of permits limited by the maximum
amount of pollution you wish to allow.  It might be possible adapt
this to free-software by allowing having permits to sell non-free
software.  But that requires a large shift in how this are
accomplished.

But the assertion made by Al Viro that software maintenance is where
the bulk of the work is, is interesting.  Long term this is trivially
true because the all of the code has been written, and there is no new
development to do.  Services like distributions and device driver
writers, and kernel maintainers appear to be in the area where
maintenance is important.  Maintenance can be handled by
maintenance/support contracts, making the economic model with closed
source and open source the same, except with open source it is easier
for multiple maintainers to cooperate.  And in the areas where the
work is primarily maintenance is where open source has been observed
to be well funded so this appears to work in practice.

Given that software maintenance is the primary problem, it is only
the creators of innovative open source programs whose costs are
external to the economic model, that making business plans harder to
deal with.  So the question becomes how in the open source community
do we encourage true innovation, while not encouraging it so much we
fail to weed out the dumb ideas.  Innovation always has a large share
of external benefit so the problem of how to encourage and compensate
innovators is not new, but the open source landscape is.

The only idea that spring to my mind to encourage true innovation are
obligating the distributors to pay the innovators something for the
programs they distribute.  Or having universities and other research
institutions pay the salaries of the researchers.  Off the top of my
head I cannot think of anything that takes advantage of the potential
to bypass an old guard of maintainers, and universities and go
directly to the consumer.

Eric
