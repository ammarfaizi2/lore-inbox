Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265449AbTFRRuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbTFRRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:50:46 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:17306 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265449AbTFRRun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:50:43 -0400
Date: Wed, 18 Jun 2003 20:04:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Check in new SN2 file from Jes' gettimeoffset() patch.
In-Reply-To: <200306181626.h5IGQbH4027481@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0306182003320.7606-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1063.9.23, 2003/05/14 17:56:37-07:00, davidm@tiger.hpl.hp.com
> 
> 	Check in new SN2 file from Jes' gettimeoffset() patch.
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1063.9.22 -> 1.1063.9.23
> #	               (new)	        -> 1.1     timer.c        
> #
> 
>  timer.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 85 insertions(+)
> 
> 
> diff -Nru a/timer.c b/timer.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/timer.c	Wed Jun 18 09:26:40 2003
        ^^^^^^^
> @@ -0,0 +1,85 @@
> +/*
> + * linux/arch/ia64/sn/kernel/sn2/timer.c
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Just wondering, did this file really end up where it belongs?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

