Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291290AbSAaU6c>; Thu, 31 Jan 2002 15:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291298AbSAaU6W>; Thu, 31 Jan 2002 15:58:22 -0500
Received: from mail.sonytel.be ([193.74.243.200]:18372 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291290AbSAaU6O>;
	Thu, 31 Jan 2002 15:58:14 -0500
Date: Thu, 31 Jan 2002 21:57:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>, Vojtech Pavlik <vojtech@ucw.cz>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Q40 input api support.
In-Reply-To: <Pine.LNX.4.10.10201311009140.23385-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0201312155500.24581-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, James Simmons wrote:
> This patch ports q40 PS/2 controller support over to the input api. Please
> try it out. It is against the latest dave jones tree.

> diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/q40kbd.c linux/drivers/input/serio/q40kbd.c
> --- linux-2.5.2-dj7/drivers/input/serio/q40kbd.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/input/serio/q40kbd.c	Thu Jan 31 10:41:56 2002
> @@ -0,0 +1,104 @@
> +/*
> + * $Id: q40kbd.c,v 1.9 2002/01/23 06:20:52 jsimmons Exp $
> + *
> + *  Copyright (c) 2000-2001 Vojtech Pavlik
> + *
> + *  Based on the work of:
> + *	unknown author

Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

