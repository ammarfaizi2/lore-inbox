Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDWG41>; Mon, 23 Apr 2001 02:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRDWG4R>; Mon, 23 Apr 2001 02:56:17 -0400
Received: from hood.tvd.be ([195.162.196.21]:53153 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S131424AbRDWGz7>;
	Mon, 23 Apr 2001 02:55:59 -0400
Date: Mon, 23 Apr 2001 08:54:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jes Sorensen <jes@linuxcare.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Philip Blundell <philb@gnu.org>, junio@siamese.dhis.twinsun.com,
        Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <d366fw29sv.fsf@lxplus015.cern.ch>
Message-ID: <Pine.LNX.4.05.10104230853400.14679-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2001, Jes Sorensen wrote:
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> Alan> The recommended compilers for non x86 are different too - eg you
> Alan> need 2.96 gcc for IA64, you need 2.95 not egcs for mips and so
> Alan> on.
> 
> In principle you just need 2.7.2.3 for m68k, but someone decided to
> raise the bar for all architectures by putting a check in a common
> header file.

Late 2.3.x proved to be very unstable for user applications (daily cron always
segfaulted somewhere), until I upgraded from 2.7.2.3 to 2.95.2 from Debian.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

