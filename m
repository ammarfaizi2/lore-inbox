Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbRFUU3b>; Thu, 21 Jun 2001 16:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265199AbRFUU3V>; Thu, 21 Jun 2001 16:29:21 -0400
Received: from 180.ppp139.rsd.worldonline.se ([213.204.139.180]:19703 "EHLO
	naut") by vger.kernel.org with ESMTP id <S265198AbRFUU3I>;
	Thu, 21 Jun 2001 16:29:08 -0400
Date: Thu, 21 Jun 2001 22:32:39 +0200
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fealnx problem
Message-ID: <20010621223238.A1157@naut>
In-Reply-To: <20010621145759.B10047@naut> <20010621212139.A13297@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621212139.A13297@se1.cogenit.fr>; from romieu@cogenit.fr on Thu, Jun 21, 2001 at 09:21:39PM +0200
From: Jon Forsberg <zzed@cyberdude.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 09:21:39PM +0200, Francois Romieu wrote:
> Jon Forsberg <zzed@cyberdude.com> écrit :
> > I have an Surecom EP-320X-S Ethernet adapter which apparently uses a
> > Myson MTD-8xx chip. It works well with the "fealnx" driver (labeled
> > "Myson MTD-8xx PCI Ethernet support" in kernel config) except for one thing: 
> > After a while in use it stops working and prints
> > 
> > Jun 21 12:18:18 naut kernel: NETDEV WATCHDOG: eth0: transmit timed out
> [...]
> 
> Could you give this a try please ?
> It may crash.

Prints the same messages as before but continues working afterwards. No need
for ifdown/ifup in other words. No crash so far.

--zzed
