Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268640AbTGNJlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 05:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbTGNJlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 05:41:09 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:30460 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268640AbTGNJlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 05:41:07 -0400
Date: Mon, 14 Jul 2003 11:55:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Morris <jmorris@intercode.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: kmap_types.h (was: Re: Linux 2.4.22-pre3)
In-Reply-To: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0307141153340.20906-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Marcelo Tosatti wrote:
>   o [CRYPTO-2.4]: Add dummy kmap_types.h header for sparc64

What are the actual purpose and semantics of the KM_* types? I need to add them
for m68k to make crypto compile.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

