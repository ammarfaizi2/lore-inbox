Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271711AbRH0Mpx>; Mon, 27 Aug 2001 08:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271713AbRH0Mpn>; Mon, 27 Aug 2001 08:45:43 -0400
Received: from alto.i-cable.com ([210.80.60.4]:19333 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S271711AbRH0Mpc>;
	Mon, 27 Aug 2001 08:45:32 -0400
Date: Mon, 27 Aug 2001 20:45:33 +0800 (HKT)
Message-Id: <200108271245.UAA12261@alto.i-cable.com>
From: Thomas Graham <lkthomas@hkicable.com>
Reply-To: Thomas Graham <lkthomas@hkicable.com>
Subject: Re: emu10k1 driver breakdown in 2.4.9?
To: rui.p.m.sousa@clix.pt
Cc: Thunder from the hill <schemins@netscape.net>,
        linux-kernel@vger.kernel.org, emu10k1-devel@opensource.creative.com
X-Mailer: Gmail 0.7.5 (http://gmail.linuxpower.org)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7TmGhBZsBIjmnxqbMl9L"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=-7TmGhBZsBIjmnxqbMl9L
Content-Type: text/plain
Content-Id: 1


> On Sat, 25 Aug 2001, Thunder from the hill wrote:
> 
> Can you strace the player giving you trouble?
> Do you see any kernel oops in /var/log/messages?
> 
> Rui Sousa
> 
> >
> > ---------4f17ff67523f7284f17ff67523f728
> > Content-Type: text/plain; charset=iso-8859-1
> > Content-Transfer-Encoding: 8bit
> > Content-Disposition: inline
> >
> > Hi,
> >
> > I am running Linux 2.4.9 compiled on gcc-2.95.2 with K6-II optimization and support for the emu10k1 cards, as I'm using a SB Live!. But whenever I play something that does not go straight to the soundcard (e.g. mp3), the program receives a SIGSEGV. No matter which program.
> > It all worked fine on Linux-2.4.2, so it seems not the players fault.
> >
> > config.h appended.
> >
> > Thunder
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
How to run K6-II optimization ?
and if I am using emu10k1 driver from creative ( not use kernel one ) , only 2speaker are work fine ( I have creative FPS2000 speaker ), why ?


--=-7TmGhBZsBIjmnxqbMl9L--

