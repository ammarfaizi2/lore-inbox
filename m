Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRDETje>; Thu, 5 Apr 2001 15:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132978AbRDETjY>; Thu, 5 Apr 2001 15:39:24 -0400
Received: from hood.tvd.be ([195.162.196.21]:19278 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S132593AbRDETjK>;
	Thu, 5 Apr 2001 15:39:10 -0400
Date: Thu, 5 Apr 2001 21:37:39 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.05.10104052040410.754-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10104052136070.509-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, my 2.4.3-pre8 kernel just said

| sym53c875-0:0: ERROR (81:0) (3-21-0) (10/9d) @ (script 8a8:0b000000).
| sym53c875-0: script cmd = 11000000
| sym53c875-0: regdump: da 10 80 9d 47 10 00 0d 00 03 80 21 80 01 09 09 00 30 4e 00 08 ff ff ff.
| sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)

during the boot process, and continued without problems. What does this mean?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


