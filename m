Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266585AbSKGVg5>; Thu, 7 Nov 2002 16:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbSKGVg5>; Thu, 7 Nov 2002 16:36:57 -0500
Received: from p50829F9A.dip.t-dialin.net ([80.130.159.154]:18958 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S266585AbSKGVg4>; Thu, 7 Nov 2002 16:36:56 -0500
Date: Thu, 7 Nov 2002 21:43:03 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: George France <france@handhelds.org>,
       axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net, ink@jurassic.park.msu.ru
Subject: Re: [PATCH] eliminate compile warnings
Message-ID: <20021107214302.C17028@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	George France <france@handhelds.org>,
	axp-list mailing list <axp-list@redhat.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	rth@twiddle.net, ink@jurassic.park.msu.ru
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <02110709222600.14483@shadowfax.middleearth> <3DCA9A88.4060109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3DCA9A88.4060109@pobox.com>; from jgarzik@pobox.com on Thu, Nov 07, 2002 at 11:53:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:53:28AM -0500, Jeff Garzik wrote:
> George France wrote:
> > On Wednesday 06 November 2002 16:47, Thorsten Kranzkowski wrote:
> > 
> >>Hello!
> >>
> >>My attempt to compile 2.5.46 with gcc 3.3 resulted in over 66% lines of the
> >>form:
[...]
> >>BTW who is the current maintainer for Alpha issues? MAINTAINERS has no
> >>entry :-/
> > 
> > 
> > If there is no entry in the MAINTAINERS file, then it is Linus.  He did the Alpha port.
[...]
> > migration of Linux to other platforms.  Linus is still the MAINTAINER for Alpha to this day.
> > He still has his loaner box from Digital.
> 
> 
> Weeeellll....  If you want to go by the "if there is no listing in 
> MAINTAINERS" rule, sure :)
> 
> Richard Henderson can be considered the current alphalinux kernel 
> maintainer for 2.4.x and 2.5.x, though he gets help from Ivan Kokshaysky 
> and Jay Estabrook, and a tiny bit of help from me too.

Richard or Ivan, would you mind being listed in MAINTAINERS ?

> So at the very least, please make sure alpha kernel patches get CC'd to 
> rth@twiddle.net and ink@jurassic.park.msu.ru.
> 
> 	Jeff

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
