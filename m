Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTBUJAc>; Fri, 21 Feb 2003 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTBUJAc>; Fri, 21 Feb 2003 04:00:32 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:1445 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267253AbTBUJAc>;
	Fri, 21 Feb 2003 04:00:32 -0500
Date: Fri, 21 Feb 2003 10:09:45 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <1045778401.1201.17.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0302211007080.9232-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2003, Antonino Daplas wrote:
> Note: I cannot test with 12x22 fonts in 2.4 because some/most drivers do
> not support it.

Which specific drivers are you talking about? All drivers for popular cards
support fontwidth 12 (Matrox, ATI, nVidia, 3Dfx, Permedia, VESA, ...).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

