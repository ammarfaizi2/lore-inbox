Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264012AbRFEPXq>; Tue, 5 Jun 2001 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264013AbRFEPXg>; Tue, 5 Jun 2001 11:23:36 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:1540 "HELO sh0n.net")
	by vger.kernel.org with SMTP id <S264012AbRFEPXV>;
	Tue, 5 Jun 2001 11:23:21 -0400
Date: Tue, 5 Jun 2001 11:23:55 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: George Bonser <george@gator.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre1 unresolved symbols
In-Reply-To: <CHEKKPICCNOGICGMDODJKENIDDAA.george@gator.com>
Message-ID: <Pine.LNX.4.30.0106051123270.142-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed unresolves symbols for the netfilter modules. this occurs
durning depmod -a.

Shawn.

On Tue, 5 Jun 2001, George Bonser wrote:

>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/net/3c59x.o
> depmod:         do_softirq
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/net/bonding.o
> depmod:         do_softirq
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/net/plip.o
> depmod:         tasklet_hi_schedule
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/net/ppp_generic.o
> depmod:         do_softirq
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/net/slip.o
> depmod:         do_softirq
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/scsi/imm.o
> depmod:         tasklet_hi_schedule
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/drivers/scsi/ppa.o
> depmod:         tasklet_hi_schedule
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre1/kernel/net/ipv6/ipv6.o
> depmod:         do_softirq
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

