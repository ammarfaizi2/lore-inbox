Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSHWGb2>; Fri, 23 Aug 2002 02:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHWGb2>; Fri, 23 Aug 2002 02:31:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:16260 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S318356AbSHWGb2>;
	Fri, 23 Aug 2002 02:31:28 -0400
Date: Fri, 23 Aug 2002 08:35:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Silvio Cesare <silvio@qualys.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH TRIVIAL] 2.5.31/drivers/zorro/proc.c
In-Reply-To: <20020822104127.A7911@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0208230832200.15607-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Silvio Cesare wrote:
> trivial patch to use loff_t and not int.

Thanks! Applied to Linux/m68k CVS (2.4.x and 2.5.x).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

