Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289175AbSANOkf>; Mon, 14 Jan 2002 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289246AbSANOkZ>; Mon, 14 Jan 2002 09:40:25 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47369 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289175AbSANOkP>; Mon, 14 Jan 2002 09:40:15 -0500
Date: Mon, 14 Jan 2002 15:40:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: <yodaiken@fsmlabs.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114063850.C22065@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0201141530450.29505-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jan 2002 yodaiken@fsmlabs.com wrote:

> > > 	Nobody has answered my question about the conflict between SMP per-cpu caching
> > > 	and preempt. Since NUMA is apparently the future of MP in the PC world and
> > > 	the future of Linux servers, it's interesting to consider this tradeoff.
> >
> > Preempt is a UP feature so far.
>
> I think this is a sufficient summary of your engineering approach.

Would you please care to explain, what the hell you want?
Preempt on SMP has more problems than you mention above, so that the scope
of my arguments only included UP. Sorry, if I missed something, but
preempt on SMP is an entirely different dicussion.

> > More of other FUD deleted, Victor, could you please stop this?
>
> I guess that Andrew, Alan, Andrea and I all are raising objections that
> you ignore because we  have some kind of shared bias.

No, your sparse use of arguments makes the difference.

bye, Roman

