Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318167AbSHIGp6>; Fri, 9 Aug 2002 02:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSHIGp5>; Fri, 9 Aug 2002 02:45:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50445 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318167AbSHIGp5>; Fri, 9 Aug 2002 02:45:57 -0400
Message-ID: <3D5364C2.9030106@evision.ag>
Date: Fri, 09 Aug 2002 08:44:18 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
References: <Pine.LNX.4.10.10208081052270.25573-100000@master.linux-ide.org>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andre Hedrick napisa?:
> Because I can not get a FSCKING PATCH past any of the Lead Penquins.
> 
> /src/linux-2.5.4-pristine/drivers/ide/ide-pci.c
> #ifdef CONFIG_PDC202XX_FORCE
>         {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
> INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
> ON_BOARD,
> 48 },
> #else /* !CONFIG_PDC202XX_FORCE */
>         {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
> INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> OFF_BOARD,
> 48 },
> #endif
> 
> But since there is the option to compile off-board as bootable, it is a
> noop.  I have not been able to directly add code or update any kernel
> first hand since the change in 2.5.3 and my exit of Linux Development at
> 2.5.5.  So I really don't give a damn.
> 
> But what I do know is people bug me for patches and updates and ask me to
> fix 2.5.XX on a regular bases.  Nobody takes my patches but man when crap
> hits the fan they come running for me to put it right again.

Bullshit. First you have to send patches out at all before they can be
accepted or rejected. As far as I'm concerned I never saw anything from
him.

