Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283888AbRLACHf>; Fri, 30 Nov 2001 21:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283889AbRLACHZ>; Fri, 30 Nov 2001 21:07:25 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:7943 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283888AbRLACHM>; Fri, 30 Nov 2001 21:07:12 -0500
Date: Fri, 30 Nov 2001 18:17:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Andrew Morton <akpm@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130171510.B19152@work.bitmover.com>
Message-ID: <Pine.LNX.4.40.0111301810400.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Larry McVoy wrote:

> On Fri, Nov 30, 2001 at 05:13:38PM -0800, Davide Libenzi wrote:
> > On Fri, 30 Nov 2001, Larry McVoy wrote:
> > Wait a minute.
> > Wasn't it you that were screaming against Sun, leaving their team because
> > their SMP decisions about scaling sucked, because their OS was bloated
> > like hell with sync spinlocks, saying that they tried to make it scale but
> > they failed miserably ?
>
> Yup, that's me, guilty on all charges.
>
> > What is changed now to make Solaris, a fairly vanishing OS, to be the
> > reference OS/devmodel for every kernel developer ?
>
> It's not.  I never said that we should solve the same problems the same
> way that Sun did, go back and read the posting.

This is your quote Larry :

<>
If you want to try and make Linux people work like Sun people, I think
that's going to be tough.  First of all, Sun has a pretty small kernel
group, they work closely with each other, and they are full time,
highly paid, professionals working with a culture that is intolerant of
anything but the best.  It's a cool place to be, to learn, but I think
it is virtually impossible to replicate in a distributed team, with way
more people, who are not paid the same or working in the same way.
<>

So, if these guys are smart, work hard and are professionals, why did they
take bad design decisions ?
Why didn't they implemented different solutions like, let's say "multiple
independent OSs running on clusters of 4 CPUs" ?
What we really have to like about Sun ?
Me personally, if I've to choose, I'll take the logo.




- Davide


