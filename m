Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273788AbRI0SXg>; Thu, 27 Sep 2001 14:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273784AbRI0SXZ>; Thu, 27 Sep 2001 14:23:25 -0400
Received: from pasky.ji.cz ([62.44.12.54]:3575 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S273781AbRI0SXO>;
	Thu, 27 Sep 2001 14:23:14 -0400
Date: Thu, 27 Sep 2001 20:23:40 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: "George R.Kasica" <georgek@netwrx1.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10
Message-ID: <20010927202339.H1149@pasky.ji.cz>
Mail-Followup-To: George R. Kasica <georgek@netwrx1.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <vsg6rto5cqtmj8dld5mc41mpvlbrf4s9vl@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <vsg6rto5cqtmj8dld5mc41mpvlbrf4s9vl@4ax.com>; from georgek@netwrx1.com on Thu, Sep 27, 2001 at 10:23:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you recommend doing the upgrade or waiting for 2.4.11 or is
> there a middle ground release (2.4.6,7,8,9) that you'd recommend.
I stopped on 2.4.6, using it from its release, and it seems rock-stable
to me - it was with p75 (amd k5 133mhz) with 32mb ram, sometimes under
really HEAVY load with all memory full; infinite loop consuming
all the memory ;), now with amd k6 singing in the rythm of 500mhz,
and w/o any problems. It is used as my desktop machine (bunch
of vims, sometimes even X+wm) and as the server (binds, postfix/qmail,
apache..) as well. If you aren't doing unusual things on exotic hardware
(ok, via soundcard driver has a problems ;), you should be happy with
this.. The last mainstream kernel with sane vm :-).

-- 

				Petr "Pasky" Baudis
.                                                                       .
        n = ((n >>  1) & 0x55555555) | ((n <<  1) & 0xaaaaaaaa);
        n = ((n >>  2) & 0x33333333) | ((n <<  2) & 0xcccccccc);
        n = ((n >>  4) & 0x0f0f0f0f) | ((n <<  4) & 0xf0f0f0f0);
        n = ((n >>  8) & 0x00ff00ff) | ((n <<  8) & 0xff00ff00);
        n = ((n >> 16) & 0x0000ffff) | ((n << 16) & 0xffff0000);
                -- C code which reverses the bits in a word.
.                                                                       .
My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
