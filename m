Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbTC0Kbl>; Thu, 27 Mar 2003 05:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbTC0Kbl>; Thu, 27 Mar 2003 05:31:41 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:33170 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261899AbTC0Kbk>;
	Thu, 27 Mar 2003 05:31:40 -0500
Date: Thu, 27 Mar 2003 11:42:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre6
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0303271140160.26358-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Marcelo Tosatti wrote:
> Here goes -pre6.
> 
> We are approaching -rc stage. I plan to release -pre7 shortly which should
> fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.

Is IDE in 2.4.x and 2.5.x now more or less in sync?

I have some m68k (at least for Amiga builtin) IDE updates for 2.5.x, but am
still waiting for the other m68k platforms to send them in. But if 2.4.21 is
approaching very soon, I better hurry up backporting them to 2.4.x...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

