Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTDWOUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTDWOUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:20:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:2802 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S264047AbTDWOUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:20:35 -0400
Date: Wed, 23 Apr 2003 16:32:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
In-Reply-To: <20030423135100.GA320@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Pavel Machek wrote:
> Swsusp without swap makes no sense, but leads to compilation
> failure. This fixes it. Please apply,

Just wondering, what about MMU-less machines?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

