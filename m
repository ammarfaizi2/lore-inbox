Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137074AbREKHrJ>; Fri, 11 May 2001 03:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137076AbREKHq7>; Fri, 11 May 2001 03:46:59 -0400
Received: from hood.tvd.be ([195.162.196.21]:26496 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S137074AbREKHqr>;
	Fri, 11 May 2001 03:46:47 -0400
Date: Fri, 11 May 2001 09:45:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: nicklong@home.com
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ncr53c8xx - DAT detection problem - 2.2.14-5
In-Reply-To: <3AFB4F54.9D63FC3F@bigfoot.com>
Message-ID: <Pine.LNX.4.05.10105110944520.1624-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001, Tim Moore wrote:
> Any clues as to why /dev/st0 is never initialized for DAT tape?  Please cc nicklong@home.com if more
> info is needed.

Make sure CONFIG_CHR_DEV_ST=[ym]

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

