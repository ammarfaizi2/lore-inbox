Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262552AbREWHTb>; Wed, 23 May 2001 03:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbREWHTV>; Wed, 23 May 2001 03:19:21 -0400
Received: from aeon.tvd.be ([195.162.196.20]:62561 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S262552AbREWHTG>;
	Wed, 23 May 2001 03:19:06 -0400
Date: Wed, 23 May 2001 09:17:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac14 
In-Reply-To: <7185.990583519@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.05.10105230915100.16280-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Keith Owens wrote:
> Is drivers/char/ser_a2232fw.ax supposed to be included?  Nothing uses it.

It's the source for the firmware hexdump in ser_a2232fw.h, provided as a
reference.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

