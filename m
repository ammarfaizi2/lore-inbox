Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHVSPn>; Thu, 22 Aug 2002 14:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHVSPn>; Thu, 22 Aug 2002 14:15:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:26804 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315374AbSHVSPn>;
	Thu, 22 Aug 2002 14:15:43 -0400
Date: Thu, 22 Aug 2002 20:19:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Paul Mackerras <paulus@au1.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] broken cfb* support in the 2.5.31-bk
In-Reply-To: <Pine.LNX.4.33.0208220950170.8777-100000@maxwell.earthlink.net>
Message-ID: <Pine.GSO.4.21.0208222017590.9137-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, James Simmons wrote:
> > Anyway, you could apply this patch, for a start.  I wish you would be
> > a bit more careful about details.
> 
> Done. Well the good news is I have aquired more hardware for different
> platforms to test my work on :-)

You don't need more hardware to protect yourself against such typos. A
cross-compiler (or sometimes even your native gcc) is sufficient ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

