Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132808AbRC2Sky>; Thu, 29 Mar 2001 13:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRC2Sko>; Thu, 29 Mar 2001 13:40:44 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:2486 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132808AbRC2Skf>; Thu, 29 Mar 2001 13:40:35 -0500
Date: Thu, 29 Mar 2001 13:39:27 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Message-ID: <20010329133927.A9950@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01032910124007.00454@neo> <0103291819180K.00454@neo> <20010329112507.A27209@devserv.devel.redhat.com> <01032920202300.00483@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032920202300.00483@neo>; from k@ailis.de on Thu, Mar 29, 2001 at 08:20:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Reimer (k@ailis.de) said: 
> Hi,
> 
> > > modprobe opl3sa2 io=0x538 mss_io=0x530 mpu_io=0x330 irq=5 dma=1 dma2=0
> > > isapnp=0
> > It would be what you put in the io= parameter. 0x538 does *not* look
> > right.
> 
> These are the sound-settings in the BIOS:
> 
> WSS I/O: 0x530
> SBPro I/O: 0x220
> Synth I/O: 0x388
> IRQ: 5
> WSS (Play) DMA: 1
> WSS (Rec) DMA & SBPro-DMA: 0
> Control I/O: 0x538
> MPU I/O: 0x330

Hm, OK, then never mind. :) I don't have an opl3sa2 here to test
how well the current driver works.

Bill
