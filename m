Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131434AbQKZQXk>; Sun, 26 Nov 2000 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132068AbQKZQXa>; Sun, 26 Nov 2000 11:23:30 -0500
Received: from [193.120.224.170] ([193.120.224.170]:40095 "EHLO
        florence.itg.ie") by vger.kernel.org with ESMTP id <S131434AbQKZQXS>;
        Sun, 26 Nov 2000 11:23:18 -0500
Date: Sun, 26 Nov 2000 15:53:11 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with hp C1537A tape drives
In-Reply-To: <Pine.LNX.4.30.0011260739550.1949-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.30.0011261547010.892-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops.. yes.. that info might have been useful. :)

The box is a Compaq PL3000. Chipset is the onboard Sym 53c876, driven
by the ncr53c8xx driver. Drive is external.

Kernel is RH6.2 default 2.2.14-5.0smp.

On Sun, 26 Nov 2000, Mr. James W. Laferriere wrote:

>
> 	Hello Paul ,  Could you add a little more info like which scsi
> 	chipset you are using & what the driver version is & what kernel
> 	version you are running also (One more )& how you have the drive
> 	chained to the scsi-bus .  Someplace there is a pointer on howto
> 	reset the scsi-bus from the /proc system , BUT the method is
> 	highly not recommended .  Hth ,  JimL

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
