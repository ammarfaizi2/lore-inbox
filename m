Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUBBRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUBBRMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:12:08 -0500
Received: from witte.sonytel.be ([80.88.33.193]:51434 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265756AbUBBRMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:12:03 -0500
Date: Mon, 2 Feb 2004 18:11:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Timothy Miller <miller@techsource.com>
cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <401E8536.5000805@techsource.com>
Message-ID: <Pine.GSO.4.58.0402021810340.19699@waterleaf.sonytel.be>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com> <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
 <401E8536.5000805@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004, Timothy Miller wrote:
> Geert Uytterhoeven wrote:
> > On Thu, 29 Jan 2004, Timothy Miller wrote:
> >>Oh, there's one thing I forgot.  It would have to support VGA.  There is
> >>a VGA core on opencores.org that we could use, but its logic area would
> >>probably push up the FPGA cost so that the board was in the $100 range.
> >>  Probably more.
> >
> >
> > Why support legacy VGA? It makes things more complex and expensive, and doesn't
> > give us much, especially for a SoC.
>
> It's all about console support in a PC.
>
> BTW, What is SoC?

System-on-a-Chip, i.e. a complete solution in one chip.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
