Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRGKIlh>; Wed, 11 Jul 2001 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbRGKIlQ>; Wed, 11 Jul 2001 04:41:16 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:4482 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S267235AbRGKIlP>;
	Wed, 11 Jul 2001 04:41:15 -0400
Date: Wed, 11 Jul 2001 10:40:49 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Wakko Warner <wakko@animx.eu.org>, daniel sheltraw <l5gibson@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: CardBus and PCI
Message-ID: <20010711104049.F7424@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <F34guA8M6XQQez1enAq000153a1@hotmail.com> <3B4B6DB8.F26663A1@mandrakesoft.com> <20010710213830.A13597@animx.eu.org> <3B4BB3B0.F6FB3443@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4BB3B0.F6FB3443@mandrakesoft.com>
User-Agent: Mutt/1.3.19i
X-Uptime: 09:20:43 up 28 min,  4 users,  load average: 0.76, 0.67, 0.48
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff Garzik,

> Wakko Warner wrote:
> > > > If a CardBus card is in a slot at boot time is it treated as PCI device
> > > > would be? Is it just another device on another PCI bus?
> > >
> > > In kernel 2.4 and using kernel cardbus support, yes.
> > 
> > But is it possible for it to be configured at boot time (like to use it for
> > nfsroot)
> 
> In kernel 2.4 and using kernel cardbus support, yes.

It didn't work for me a few kernels back as the cardbus nic got active
after the assignment of the ip address and after the nfsroot mount
(which both failed because of that).

	Ookhoi
