Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTKZVY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTKZVY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:24:58 -0500
Received: from witte.sonytel.be ([80.88.33.193]:56499 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264326AbTKZVY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:24:57 -0500
Date: Wed, 26 Nov 2003 22:24:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jes Sorensen <jes@wildopensource.com>
cc: Nikita Melnikov <ku3@stud2.aanet.ru>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: m68k & 2.6.0
In-Reply-To: <yq0n0aj74mj.fsf@wildopensource.com>
Message-ID: <Pine.GSO.4.21.0311262221510.18863-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2003, Jes Sorensen wrote:
> >>>>> "Nikita" == Nikita Melnikov <ku3@stud2.aanet.ru> writes:
> 
> Nikita> Hello.  What is the state of 2.6 kernels on m68k architecture?
> Nikita> Is it possible to run new kernels on 68040 and other old
> Nikita> processors?
> 
> Hi Nikita,
> 
> Try asking on linux-m68k@lists.linux-m68k.org

It mainly depends on your hardware. E.g. 2.6.0-test9 works on my Amiga 4000
with 68040.

Check out Linux/m68k CVS: http://linux-m68k-cvs.apia.dhs.org/

Patch integration status:
    http://linux-m68k-cvs.apia.dhs.org/~geert/linux-m68k-2.4.x-merging/
    http://linux-m68k-cvs.apia.dhs.org/~geert/linux-m68k-2.5.x-merging/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

