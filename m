Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbRHKPRI>; Sat, 11 Aug 2001 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268206AbRHKPQ6>; Sat, 11 Aug 2001 11:16:58 -0400
Received: from [209.202.108.240] ([209.202.108.240]:24336 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S268199AbRHKPQw>; Sat, 11 Aug 2001 11:16:52 -0400
Date: Sat, 11 Aug 2001 11:16:51 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: strange gcc crashes...
In-Reply-To: <E15VaDR-000N0H-00@f9.mail.ru>
Message-ID: <Pine.LNX.4.33.0108111114160.19268-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Samium Gromoff wrote:

>        I`ve experienced strange gcc sig11 crashes.
>     prerequisities: gcc-2.95.3-vanille, 2.4.7-vanille
>
>     recently i`ve dloaded arachne, a svgalib-based
>     web browser. It has quite a number of various problems,
>     with console-switching screen/terminal corruptions
>     being most significant. so as i said, it crashed
>     alot, and i recovered from these crashes w/o reboot.
>
>     then i get libggi-2.0.4b4. (that is all happening
>     w/o reboot between actions)
>
>     i`ve started compile process. bah! - sig11.
>
>     Although i quite often have those, but
>     this time i had about _100_ of them!!!
>     all these in libggi. I `ve got tired of tweakin`
>     cflags of different makfiles, because it helps
>     to go thru prblematic .c`s, and i rebooted.
>
>     Hm the /most/ mystic of all this is the fact, that
>     after reboot sig11 rate dropped from sig11 per ~4
>     files to one per ~120 of them. To make clear
>     the situation, i`ll tell that libggi is VERY
>     broken for me in the scope of gcc`s sig11.
>
>     also i can say, that the sig11/file rate had been
>     constantly increasing with the compilation process.
>
>     so it seems to me like kernel problem...
>
>     further information upon request.
>
> ---
> cheers,
>    Samium Gromoff

Sounds like flaky hardware. Something in your system is probably overheating
and causing problems. Try swapping the components in your system one at a
time, starting with memory.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

