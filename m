Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTGIGyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTGIGyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:54:10 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:35766 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265074AbTGIGyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:54:08 -0400
Date: Wed, 9 Jul 2003 09:08:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
 support
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0307090907140.18825-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Ingo Molnar wrote:
> i'm pleased to announce the first public release of the "4GB/4GB VM split"
> patch, for the 2.5.74 Linux kernel:
> 
>    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
> 
> The 4G/4G split feature is primarily intended for large-RAM x86 systems,
> which want to (or have to) get more kernel/user VM, at the expense of
> per-syscall TLB-flush overhead.

Great! Another enterprise feature stolen from SCO? :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

