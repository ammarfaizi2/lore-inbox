Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSKORNW>; Fri, 15 Nov 2002 12:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbSKORNW>; Fri, 15 Nov 2002 12:13:22 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11282 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S266456AbSKORNV>;
	Fri, 15 Nov 2002 12:13:21 -0500
Date: Fri, 15 Nov 2002 18:19:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Crooke <dave@convio.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20021115171951.GB553@alpha.home.local>
References: <3DD4CD06.2010009@convio.com> <1037372088.19971.11.camel@irongate.swansea.linux.org.uk> <20021115144020.GA13039@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115144020.GA13039@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:40:20PM +0000, Dave Jones wrote:
> On Fri, Nov 15, 2002 at 02:54:48PM +0000, Alan Cox wrote:
>  > Make sure you have a current BIOS on dual athlon boxes, the earlier
>  > bioses were not terribly good on the whole. Make sure you have a PS/2
>  > mouse in the mouse port even if you aren;t going to use it
> 
> Unless he's lucky with steppings, it's also possible he's being
> bitten by running XP's instead of MPs.

BTW, since I've upgraded my Asus bios, my 2 XP1800 are reported as MP1800.
There's absolutely no way for me to tell that they're in fact XPs, except
from dismounting the cooling fans and read the chips. Although they're quite
stable even at very high temperatures (I could compile a complete kernel with
fans unplugged, but the case was as hot as a pizza oven), I know that there
are people out there with unstable dual XP setups and I frankly don't know
how they could tell that they're XP if their reseller sold them as MPs and
installed the fan himself.

Cheers,
Willy

