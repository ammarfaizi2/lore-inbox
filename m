Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUBOLQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 06:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUBOLQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 06:16:16 -0500
Received: from witte.sonytel.be ([80.88.33.193]:34531 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261681AbUBOLQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 06:16:15 -0500
Date: Sun, 15 Feb 2004 12:16:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling
In-Reply-To: <20040213234554.GA32440@MAIL.13thfloor.at>
Message-ID: <Pine.GSO.4.58.0402151214520.22078@waterleaf.sonytel.be>
References: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel>
 <p73n07my8nn.fsf@verdi.suse.de> <20040213234554.GA32440@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Feb 2004, Herbert Poetzl wrote:
>   linux-2.4.25-rc2        config  dep     kernel  modules
>   m68k/m68k:              OK      OK      OK      OK

Good! :-)

One related question: anyone who knows how to run a cross-depmod, so I can find
missing symbol exports without running depmod on the target?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
