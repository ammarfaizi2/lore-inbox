Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136524AbRD3WYa>; Mon, 30 Apr 2001 18:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136526AbRD3WYW>; Mon, 30 Apr 2001 18:24:22 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:17869
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S136524AbRD3WYG>; Mon, 30 Apr 2001 18:24:06 -0400
Date: Mon, 30 Apr 2001 15:21:45 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Elmer Joandi <elmer@linking.ee>,
        Ookhoi <ookhoi@dds.nl>, linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
In-Reply-To: <20010430181056.A10487@alcove.wittsend.com>
Message-ID: <Pine.LNX.4.21.0104301518330.32730-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Michael H. Warfield wrote:
[...]
> >    But now I get the same missing symbols I initially had in 2.4.3:
> 
> > Apr 30 13:19:34 oleron cardmgr[148]: initializing socket 0
> > Apr 30 13:19:34 oleron cardmgr[148]: socket 0: Aironet PC4800
> > Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_core'
> > Apr 30 13:19:34 oleron cardmgr[148]: + Warning: /lib/modules/2.4.4/kernel/drivers/net/aironet4500_core.o 
> > symbol for parameter rx_queue_len not found
> > Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_proc'
> > Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_cs'
> > Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
> > failed: Resource temporarily unavailable
> 
> 	Seen this before.  What version are your modutils at?  Latest are
> 2.4.5 on kernel.org and there have been several times where I've had
> them slip out of rev and ended up with missing symbols.

   Here I have modutils 2.4.2.


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
        War doesn't determine who's right.  War determines who's left.

