Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSL0K6W>; Fri, 27 Dec 2002 05:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSL0K6W>; Fri, 27 Dec 2002 05:58:22 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:22724 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264875AbSL0K6V>;
	Fri, 27 Dec 2002 05:58:21 -0500
Date: Fri, 27 Dec 2002 12:05:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: James Simmons <jsimmons@infradead.org>, Jurriaan <thunder7@xs4all.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: also frustrated with the framebuffer
 and your matrox-card in 2.5.53? hack/patch available!
In-Reply-To: <20021227023943.GC1412@ppc.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0212271128120.17037-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2002, Petr Vandrovec wrote:
> On Thu, Dec 26, 2002 at 07:47:52PM +0000, James Simmons wrote:
> > Petr is expressing his political view. It has nothing to do with technical 
> > arguments. In fact I place a bet. I will port the matrox driver and it 
> > will have the same functionality as the previous driver except for text 
> > mode support. If I can't do it I will not only revert the changes but I 
> 
> Yes. Without text mode support. But without textmode support that driver is
> of no use for me because of it is not compatible with VMware then.

What exactly in the new fbdev API is preventing you from having text mode
support?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

