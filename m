Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273350AbRIWVt2>; Sun, 23 Sep 2001 17:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273326AbRIWVtS>; Sun, 23 Sep 2001 17:49:18 -0400
Received: from [195.223.140.107] ([195.223.140.107]:16894 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S273235AbRIWVtO>;
	Sun, 23 Sep 2001 17:49:14 -0400
Date: Sun, 23 Sep 2001 23:49:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
Message-ID: <20010923234955.F1782@athlon.random>
In-Reply-To: <20010923232511.B1466@athlon.random> <m15lGv2-000OVWC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15lGv2-000OVWC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Sun, Sep 23, 2001 at 10:36:08PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 10:36:08PM +0100, arjan@fenrus.demon.nl wrote:
> In article <20010923232511.B1466@athlon.random> you wrote:
> 
> > Only in 2.4.10aa1: 00_enable-apic-1
> 
> >        Enable UP ioapic on demand via boot param.
> 
> If you took my patch for it, PLEASE don't send it for inclusion; it's an
> evil hack and no longer needed when Intel fixes the bug in their 440GX bios.

we're having troubles with the ioapic compiled in in UP on some machine,
on 2.4.10pre I assume. Waiting bios updates is more problematic then
enabling on demand rather than disabling on demand, so yes I will be
obviously glad to drop this one as soon as the problem goes away.
thanks for the info.

Andrea
