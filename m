Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUDSQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDSQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:38:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23313 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261313AbUDSQiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:38:12 -0400
Date: Mon, 19 Apr 2004 17:38:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68k)
Message-ID: <20040419173808.F29446@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk> <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>; from geert@linux-m68k.org on Mon, Apr 19, 2004 at 06:18:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:18:41PM +0200, Geert Uytterhoeven wrote:
> --- linux-m68k-2.6.6-rc1-rmk/arch/m68k/kernel/m68k_ksyms.c	2004-04-19 15:35:42.000000000 +0200
> +++ linux-m68k-2.6.6-rc1-geert/arch/m68k/kernel/m68k_ksyms.c	2004-04-19 16:19:39.000000000 +0200
> @@ -16,6 +16,7 @@
>...

Patch merged into existing m68k patch, thanks.  I'll wait for
sun3_pgalloc.h to be resolved before posting an updated patch
though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
