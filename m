Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbUCXMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 07:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUCXMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 07:12:58 -0500
Received: from witte.sonytel.be ([80.88.33.193]:14307 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263299AbUCXMM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 07:12:57 -0500
Date: Wed, 24 Mar 2004 13:12:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Martin Zwickel <martin.zwickel@technotrend.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc2-mm2
In-Reply-To: <200403241235.51786@WOLK>
Message-ID: <Pine.GSO.4.58.0403241311580.25288@waterleaf.sonytel.be>
References: <20040323232511.1346842a.akpm@osdl.org> <20040324110014.4cdb7597@phoebee>
 <200403241235.51786@WOLK>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004, Marc-Christian Petersen wrote:
> On Wednesday 24 March 2004 11:00, Martin Zwickel wrote:
> > I'm unable to start my X server with this patch.
> > I have the nvidia 5336 module loaded and if I start the X server, the
> > machine completely freezes. With 2.6.5-rc2 everything works ok...
> > If anyone wants my config, ask me.
>
> apply this patch ontop of 2.6.5-rc2-mm2 tree to get nvidia working again.

Shouldn't it be `4kB' (or better `4kiB' :-) instead of `4Kb'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
