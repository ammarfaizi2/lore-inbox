Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTI2UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbTI2UEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:04:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:41481 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264682AbTI2UEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:04:07 -0400
Subject: Re: [2.6.0-test4,5,6] [APM] when do you expect to get APM
	workingagain?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Schierl <schierlm@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F788355.607F0178@gmx.de>
References: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org>
	 <1064841037.3970.3.camel@teapot.felipe-alfaro.com>
	 <3F788355.607F0178@gmx.de>
Content-Type: text/plain
Message-Id: <1064865843.1387.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Sep 2003 22:04:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 21:09, Michael Schierl wrote:

> I now removed several things from my test6 kernel:
> 
> - CardBus/PCMCIA support
> - Networking support
> - Mouse support
> - Sound support
> - Parallel port support
> - USB
> - AGP
> - Framebuffer support and all other graphics support except 
>   vga console
> - IDE CDROM and floppy disk Support
> - ISA bus support
> - P'n'P support
> 
> and maybe some more things I forgot now
> 
> However, no change (except I get lots of errors from services while 
> booting) - it freezes after the hard disk is shut down.
> 
> Any other ideas?

No sorry, I don't have any ideas. I accidentally found my own solution
sometime ago when I booted into single mode and tried suspending,

