Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289145AbSAGIxd>; Mon, 7 Jan 2002 03:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289144AbSAGIxX>; Mon, 7 Jan 2002 03:53:23 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:27152 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289145AbSAGIxO>; Mon, 7 Jan 2002 03:53:14 -0500
Date: Mon, 7 Jan 2002 08:53:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020107085307.A17914@flint.arm.linux.org.uk>
In-Reply-To: <20020106210233.A30319@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020106210233.A30319@thyrsus.com>; from esr@thyrsus.com on Sun, Jan 06, 2002 at 09:02:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 09:02:33PM -0500, Eric S. Raymond wrote:
> 6xx_GENERIC

What's this?  Where is it?

> ARCH_CO285
> ARCH_FOOTBRIDGE
> ARCH_SA1100
> ARCH_SHARK
> CPU_ARM922_CPU_IDLE
> CPU_ARM922_D_CACHE_ON
> CPU_ARM922_I_CACHE_ON
> CPU_ARM922_WRITETHROUGH

Erm, I don't believe these have been added since you last complained.
I don't see how they became a non-issue and are now a problem.  Please
double-check them.

> ARCH_ADIFCC
> ARCH_AUTCPU12
> ARCH_CAMELOT
> ARCH_CLPS711X
> ARCH_CLPS7500
> ARCH_IOP310
> DEBUG_WAITQ
> DEBUG_LL_SER3
> H3600_SLEEVE
> IOP310_AAU
> IOP310_DMA
> IOP310_MU
> IOP310_PMON
> SA1100_H3100
> SA1100_H3800
> SA1100_PT_SYSTEM3
> SA1100_SHANNON
> SA1100_USB
> SA1100_USB_CHAR
> SA1100_USB_NETLINK

Some of these are waiting to be dug out of my copy of the Configure.help
file and forwarded to Linus.

The only thing I'm doing at the moment is forwarding the stuff that doesn't
touch ARM specific files; Configure.help is a generic file, so it doesn't
get sent as often, and will always take longer (and therefore be out of
date).
