Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUKHSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUKHSHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUKHRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:05:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:42493 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261922AbUKHQQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:16:19 -0500
Date: Mon, 8 Nov 2004 17:16:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bk-commits: diff -p?
In-Reply-To: <1099929091.4542.83.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.61.0411081715450.4130@waterleaf.sonytel.be>
References: <Pine.LNX.4.61.0411080940310.27771@anakin>
 <1099929091.4542.83.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, David Woodhouse wrote:
> On Mon, 2004-11-08 at 09:41 +0100, Geert Uytterhoeven wrote:
> > Would it be possible to enable the `-p' option (Show which C function each
> > change is in) of diff for all patches sent to the bk-commits-* mailing lists?
> 
> I did consider that but 'bk diffs -up' gives a context diff, not a
> unified diff.

So it's a `regression' of bk diffs vs. GNU diff?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
