Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318004AbSGWJf6>; Tue, 23 Jul 2002 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318005AbSGWJf6>; Tue, 23 Jul 2002 05:35:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21768
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318004AbSGWJf6>; Tue, 23 Jul 2002 05:35:58 -0400
Date: Tue, 23 Jul 2002 02:34:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncleanness in 2.4 IDE
In-Reply-To: <Pine.LNX.4.44.0207230302580.3384-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.10.10207230233540.29975-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed but not accepted yet.

On Tue, 23 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> IDE in late 2.4 kernels always gives me things like this:
> 
> hdd: timeout waiting for DMA
> hdd: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x60
> hdd: DMA disabled
> hdd: ide_set_handler: handler not null; old=c021f610, new=c022db60
> bug: kernel timer added twice at c021f552.
> 
> >From that moment the IDE cdrom becomes unuseable.
> 
> 							Regards,
> 							Thunder
> -- 
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y- 
> ------END GEEK CODE BLOCK------
> 

Andre Hedrick
LAD Storage Consulting Group

