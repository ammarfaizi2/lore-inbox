Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133104AbRADU7o>; Thu, 4 Jan 2001 15:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135219AbRADU7e>; Thu, 4 Jan 2001 15:59:34 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:56147 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S133104AbRADU7S>; Thu, 4 Jan 2001 15:59:18 -0500
Date: Thu, 4 Jan 2001 23:06:25 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Sven Koch <haegar@cut.de>
cc: Andre Hedrick <andre@linux-ide.org>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <Pine.LNX.4.30.0101042139270.28511-100000@space.comunit.de>
Message-ID: <Pine.LNX.4.21.0101042305230.4116-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I did'nt know something like that even existed :)
> 
> Just plugged the drive into the ide controller (single drive on a
> promise ata100 in a dec alpha) and it worked.

Ah.. This is a i386 machine, UDMA33 capable, and the bloody thing won't
boot with the clipping removed, and with clipping I can use only 32 GB :((

> But I'm booting from SCSI as the machine does not support IDE-drives in
> the "bios".

This machine the other way around :)
 

	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
