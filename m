Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTFILsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTFILsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:48:51 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:63419 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263915AbTFILsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:48:50 -0400
Date: Mon, 9 Jun 2003 14:02:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sch_ingress.c includes <asm/smp.h>
In-Reply-To: <1055159413.9884.4.camel@rth.ninka.net>
Message-ID: <Pine.GSO.4.21.0306091401550.1347-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2003, David S. Miller wrote:
> On Mon, 2003-06-09 at 03:37, Geert Uytterhoeven wrote:
> > sch_ingress.c includes <asm/smp.h>, causing build failures on UMP-only
> > architectures
> 
> Geert you should know better than anyone else that
> you should send NET fixes to the NET maintainers.
> 
> So why aren't you doing that?

Sorry, forgot about that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

