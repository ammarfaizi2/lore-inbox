Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKGUW0>; Thu, 7 Nov 2002 15:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKGUWZ>; Thu, 7 Nov 2002 15:22:25 -0500
Received: from p50829F9A.dip.t-dialin.net ([80.130.159.154]:13838 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261573AbSKGUWX>; Thu, 7 Nov 2002 15:22:23 -0500
Date: Thu, 7 Nov 2002 20:28:55 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: George France <france@handhelds.org>
Cc: axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate compile warnings
Message-ID: <20021107202855.B17028@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: George France <france@handhelds.org>,
	axp-list mailing list <axp-list@redhat.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <02110709222600.14483@shadowfax.middleearth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <02110709222600.14483@shadowfax.middleearth>; from france@handhelds.org on Thu, Nov 07, 2002 at 09:22:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 09:22:26AM -0500, George France wrote:
> On Wednesday 06 November 2002 16:47, Thorsten Kranzkowski wrote:
> 
> You are brave sole. The bleeding edge cuts both ways.

And sometimes covered with a sticky red fluid ... :)

> > BTW who is the current maintainer for Alpha issues? MAINTAINERS has no
> > entry :-/
> 
> If there is no entry in the MAINTAINERS file, then it is Linus.  He did the Alpha port.

yes, I know. If the patch won't show up soon I _will_ send it to Linus.
But it's usually easier to get it in when some Maintainer sticks an OK-label
on it :-) 

> He still has his loaner box from Digital.

Well, I thought that box was already retired, but I may be wrong.

> There are still a few of us that work for the Alpha Processor Group at HP that work on
> maintaining the kernel.  I have tossed your patch into the directory that holds all
> kinds of miscellaneous alpha bits for the next time one of us looks at the kernel.

Thanks! Hopefully it won't take long to find it's way into mainline (hint hint...)

> Since people that work on the Alpha Architecture are greatly outnumbered by the
> people that work on other architectures, usually by the time we have a stable working 
> kernel for Alpha, the kernel.org kernels are usually many versions ahead.  

I'd prefer if development is tightly coupled to mainline so that the version
skew is minimized. Yes, here will be kernels that won't work for various 
reasons but that's why it's called development kernel :)

I strongly feel that _now_ is the time to sync up so we can start with a more
or less working 2.6.0 and don't have to wait until 2.6.2x ...

> 
> I hope this helps.

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
