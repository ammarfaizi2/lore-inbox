Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTICIIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTICIH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:07:29 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:42478 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261644AbTICIGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:06:00 -0400
Date: Wed, 3 Sep 2003 10:05:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kars de Jong <jongk@linux-m68k.org>
cc: Jamie Lokier <jamie@shareable.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <1062576038.1221.4.camel@laptop.locamation.com>
Message-ID: <Pine.GSO.4.21.0309031004480.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2003, Kars de Jong wrote:
> On Mon, 2003-09-01 at 10:34, Geert Uytterhoeven wrote:
> > BTW, probably you want us to run your test program on other m68k boxes? Mine
> > got a 68040, that leaves us with:
> >   - 68030
> 
> Ah, I forgot, I've got one of these here too, a Motorola MVME147 board:
> 
> sasscm:/tmp# time ./jamie_test2
> Test separation: 4096 bytes: FAIL - cache not coherent

I guess the Plessey PME 68-22 didn't have cache, since the test passed?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

