Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSFQRMO>; Mon, 17 Jun 2002 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSFQRMO>; Mon, 17 Jun 2002 13:12:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316605AbSFQRMN>; Mon, 17 Jun 2002 13:12:13 -0400
Date: Mon, 17 Jun 2002 13:12:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Nibali <ratz@drugphish.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <3D0E0E5F.20406@drugphish.ch>
Message-ID: <Pine.LNX.3.95.1020617130745.2163A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Roberto Nibali wrote:
[SNIPPED...]

> 
> Could you try with the latest 2.4.19preX tree and also replace the 
> ../drivers/ieee1394 with the CVS one?
> 
> [1] http://linux1394.sourceforge.net/svn.html
> 
> Best regards,
> Roberto Nibali, ratz
> 
> p.s.: You have to hurry up, since I'm not online very often the next few 
> weeks. Of course you could also show up at OLS with the disk ;).

Okay. I did that now. However, `depmod -ae` shows some unresolved
symbols:

depmod: *** Unresolved symbols in /lib/modules/2.4.18/kernel/drivers
    /ieee1394/pcilynx.o
depmod: 	i2c_transfer
depmod: 	i2c_bit_del_bus
depmod: 	i2c_bit_add_bus

Since I don't use this module, maybe I am "home-free" I need to try
this on my system at home since my firewire stuff is there.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.





Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

