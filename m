Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHJWSi>; Sat, 10 Aug 2002 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSHJWSh>; Sat, 10 Aug 2002 18:18:37 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:27523 "EHLO stargate")
	by vger.kernel.org with ESMTP id <S317351AbSHJWSh>;
	Sat, 10 Aug 2002 18:18:37 -0400
Date: Sun, 11 Aug 2002 00:22:30 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why not a "unsigned long long" for rx_bytes in linux/drivers/atm/horizon.h ?
Message-ID: <20020810222230.GB23786@stargate.lan>
References: <20020810221700.GA23786@stargate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020810221700.GA23786@stargate.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry, the kernel is 2.4.19
> i have seen a patch for linux/net/core/dev.c and
> linux/include/linux/netdevice.h
> 
> in the struct net_device_stats, rx_bytes is in unsigned long long, why not
> the rx_bytes of linux/drivers/atm/horizon.h ?
> 
> thanks

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
Address :
    Rue de cartier, 53
    6030 Marchienne-au-Pont
    Belgium
Phone :	+32 474 768 072
