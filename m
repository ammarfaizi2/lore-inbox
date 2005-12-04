Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVLDVuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVLDVuH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 16:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVLDVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 16:50:07 -0500
Received: from witte.sonytel.be ([80.88.33.193]:3524 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932334AbVLDVuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 16:50:06 -0500
Date: Sun, 4 Dec 2005 22:49:42 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
       Arno Griffioen <arno.griffioen@ieee.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: CONFIG_GG2 (was: Re: Some kconfig issues)
In-Reply-To: <20051203195254.GG72294@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.62.0512042237520.15120@pademelon.sonytel.be>
References: <20051203195254.GG72294@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Jean-Luc Leger wrote:
> Here are some issues regarding undefined config options in linux-2.6.15-rc4.
> Most of these are obviously not yet defined config options, but as some are mispelled configs
> I thought it would be better to send the whole list.

> GG2 in arch/m68k/Kconfig

Indeed, Amiga Golden Gate II Zorro/ISA bridge support is only partially there,
and cannot be selected.

Arno, do we still miss a lot?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
