Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVAENwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVAENwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAENwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:52:19 -0500
Received: from witte.sonytel.be ([80.88.33.193]:51336 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262423AbVAENwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:52:16 -0500
Date: Wed, 5 Jan 2005 14:51:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FRV: Fujitsu FR-V CPU arch implementation part 4
In-Reply-To: <200501050712.j057CSTU032672@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0501051450040.26733@waterleaf.sonytel.be>
References: <200501050712.j057CSTU032672@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Linux Kernel Mailing List wrote:
> ChangeSet 1.2030, 2005/01/04 21:16:47-08:00, dhowells@redhat.com
> 
> 	[PATCH] FRV: Fujitsu FR-V CPU arch implementation part 4
> 	
> 	The attached patches provides part 4 of an architecture implementation
> 	for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/frv/kernel/process.c	2005-01-04 23:12:39 -08:00
> @@ -0,0 +1,384 @@
> +/*
> + *  linux/arch/m68k/kernel/process.c
                  ^^^^
Can you please fix up these (there exist a few more) bogus file names? Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
