Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSHWKsX>; Fri, 23 Aug 2002 06:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318761AbSHWKsX>; Fri, 23 Aug 2002 06:48:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:14035 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S318760AbSHWKsW>;
	Fri, 23 Aug 2002 06:48:22 -0400
Date: Fri, 23 Aug 2002 12:50:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <Pine.LNX.4.10.10208222016350.13077-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0208231249250.15704-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2002, Andre Hedrick wrote:
> Oh and it is only useful for borken things like LINBIOS and other
> braindead systems like ARM that violate the 31 second rule of POST.

Is the 31 second rule defined for the PC or for IDE?

This would explain why my Amiga doesn't identify my Conner CP30540A after a
cold boot, because the disk isn't spun up yet. Apparently AmigaOS doesn't
follow the `31 second rule'...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

