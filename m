Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132871AbRDEMOF>; Thu, 5 Apr 2001 08:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132872AbRDEMNz>; Thu, 5 Apr 2001 08:13:55 -0400
Received: from aeon.tvd.be ([195.162.196.20]:11857 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S132871AbRDEMNf>;
	Thu, 5 Apr 2001 08:13:35 -0400
Date: Thu, 5 Apr 2001 14:12:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <m1bsqbwo3u.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.05.10104051410440.25540-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2001, Eric W. Biederman wrote:
> 32bit writes on a bus with a word size of 64 or more bits.  By the way
> does anyone know who didn't implement MTRR's or the equivalent on
> alpha so we can shoot them?

People never get shot in Open Source projects. Not when they write buggy code,
not when they don't implement some features.

Gr{oetje,eeting}s,

						Geert

P.S. Perhaps ESR tends to disagree? ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

