Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSHLUM7>; Mon, 12 Aug 2002 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSHLUM7>; Mon, 12 Aug 2002 16:12:59 -0400
Received: from WARSL402PIP5.highway.telekom.at ([195.3.96.79]:51284 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S318809AbSHLUM6>;
	Mon, 12 Aug 2002 16:12:58 -0400
Message-ID: <000701c2423d$82a847e0$8c00000a@sledgehammer>
From: "Peter Klotz" <peter.klotz@aon.at>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <000501c24230$8a29bdd0$8c00000a@sledgehammer> <1029178514.16424.205.camel@irongate.swansea.linux.org.uk>
Subject: Re: 2.4.19 and 2.4.20-pre1 don't boot
Date: Mon, 12 Aug 2002 22:18:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Up to 2.4.19-rc1 my system worked fine but 2.4.19 and 2.4.20-pre1
produce
> > the following message at startup:
> >
> > Mounting root filesystem
> > ide-floppy driver 0.99.newide
> > kmod: failed to exec /sbin/modprobe -s -k ide-cd, errno = 2
> > hda: driver not present
>
> Compile in hard disk support
>

Both options below are set to "yes" in the kernel configuration:
   Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
   Include IDE/ATA-2 DISK support




