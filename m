Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBYBAf>; Mon, 24 Feb 2003 20:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTBYBAf>; Mon, 24 Feb 2003 20:00:35 -0500
Received: from [209.195.52.120] ([209.195.52.120]:8594 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S262201AbTBYBAd>; Mon, 24 Feb 2003 20:00:33 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2003 17:09:34 -0800 (PST)
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
In-Reply-To: <351250000.1046133664@flay>
Message-ID: <Pine.LNX.4.44.0302241654450.16145-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you want to say that sales of LINUX servers generates mor profits then
sales of LINUX desktops then you have a chance of being right, not becouse
the server market is so large, but becouse the desktop market is so small.

however if the linux desktop were to get 10% of the market in terms of new
sales (it's already in the 5%-7% range according to some reports, but a
large percentage of that is in repurposed windows desktops) then the
sales and profits of the desktops would easily outclass the sales and
profits of servers due to the shear volume.

IBM and Sun make a lot of sales from the theory that their machines (you
know, the ones in fancy PC cases with PC power supplies and IDE drives)
are somehow more reliable then a x86 machine. as pwople really start
analysing the cost/performance of the machines and implement HA becouse
they need 24x7 coverage and even the big boys boxes need to be updated
people realize that they can buy multiple cheap boxes and get HA for less
then the cost of buying the one 'professional' box (in some cases they can
afford to buy the multiple smaller boxes and replace them every year for
less then the cost of the professional box over 3 years). And as more
folks use linux on the small(er) machines it breaks down the risk barrier.

one of the big reasons people have traditionally used small numbers of
large boxes was that the licensing costs have been significant, well linux
doesn't have a per server license cost (unless you really want to pay one)
so that's also no longer an issue.

there are some jobs that require large machines instead of clusters,
databases are still one of them (at least as far as I have been able to
learn) but a lot of other jobs are being moved to multiple smaller boxes
(or to multiple logical boxes on one large box which is what Larry is
advocating) and in spite of the doomsayers the problems are being worked
out (can you imagine the reaction from telling a sysadmin team managing
one server in 1970 that in 2000 a similar sized team would be managing
hundreds or thousands of servers ala google :-) yes it takes planning and
dicipline, but it's not nearly as hard as people imagine before they get
started down that path)

David Lang

On Mon, 24 Feb 2003, Martin J. Bligh wrote:

> Date: Mon, 24 Feb 2003 16:41:04 -0800
> From: Martin J. Bligh <mbligh@aracnet.com>
> To: Larry McVoy <lm@bitmover.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
>
> > More data from news.com.
> >
> > Dell has 19% of the server market with $531M/quarter in sales[1] over
> > 212,750 machines per quarter[2].
> >
> > That means that the average sale price for a server from Dell was $2495.
> >
> > The average sale price of all servers from all companies is $9347.
> >
> > I still don't see the big profits touted by the scaling fanatics, anyone
> > care to explain it?
>
> Sigh. If you're so convinced that there's no money in larger systems,
> why don't you write to Sam Palmisano and explain to him the error of
> his ways? I'm sure IBM has absolutely no market data to go on ...
>
> If only he could receive an explanation of the error of his ways from
> Larry McVoy, I'm sure he'd turn the ship around, for you obviously have
> all the facts, figures, and experience of the server market to make this
> kind of decision. I await the email from the our CEO that tells us how
> much he respects you, and has taken this decision at your bidding.
>
> M.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
