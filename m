Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSL3JD7>; Mon, 30 Dec 2002 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSL3JD6>; Mon, 30 Dec 2002 04:03:58 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:3332 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S266852AbSL3JDK>; Mon, 30 Dec 2002 04:03:10 -0500
Message-Id: <5.1.1.6.2.20021230100446.03168ec8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 30 Dec 2002 10:10:06 +0100
To: Scott McDermott <vaxerdec@frontiernet.net>, linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
In-Reply-To: <20021227191213.G16539@newbox.localdomain>
References: <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
 <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there Scott,

    my card (which not need any patch for working on in 2.4.18 but doesnt 
work (its simply not detected) on next versions) is:

HighPoint Technologies, Inc.
HPT370 UDMA/ATA100 RAID Controller BIOS v1.0.3b1

have u any idea?

Im so lost...
do u wanna /proc/cpuinfo or anything?

At 19:12 27/12/2002 -0500, Scott McDermott wrote:
>system_lists@nullzone.org on Thu 26/12 01:36 +0100:
> > i have a Highpoint 370 which doesnt work in new kernel releases.
>
>for 2.4.18 please try the patch:
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/patch-2.4.18-ac3.gz
>
> > I'm just using 2.4.18 becouse other version upper doesnt detect the
> > Raid HW card.
>
>what card?
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




