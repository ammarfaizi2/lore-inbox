Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291626AbSBAJOe>; Fri, 1 Feb 2002 04:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291627AbSBAJO1>; Fri, 1 Feb 2002 04:14:27 -0500
Received: from mail.sonytel.be ([193.74.243.200]:21413 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291624AbSBAJMn>;
	Fri, 1 Feb 2002 04:12:43 -0500
Date: Fri, 1 Feb 2002 10:11:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: James Simmons <jsimmons@transvirtual.com>, Vojtech Pavlik <vojtech@ucw.cz>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <20020201081442.G15571@suse.cz>
Message-ID: <Pine.GSO.4.21.0202011010481.25104-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Vojtech Pavlik wrote:
> On Thu, Jan 31, 2002 at 09:54:51PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 31 Jan 2002, James Simmons wrote:
> > >   The amiga mouse and amiga joystick have been already ported over to the
> > > input api. Now for the keyboard. This patch is the input api amiga
> > > keyboard. I wanted people to try it out before I send it off to be
> > > included in the DJ tree. Have fun!!!

    [...]

> > Oops, amikbd_messages[scancode-0x78]?
> 
> Thanks. And thanks to James for fixing this in the CVS as well.
> Does it work otherwise?

No idea (yet).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

