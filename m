Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSAHQZD>; Tue, 8 Jan 2002 11:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288148AbSAHQYx>; Tue, 8 Jan 2002 11:24:53 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:60800 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S288153AbSAHQYq>; Tue, 8 Jan 2002 11:24:46 -0500
Message-ID: <02ab01c19861$1a170350$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10201080115150.32597-100000@master.linux-ide.org>
Subject: Re: IDE Patch (fwd)
Date: Tue, 8 Jan 2002 17:25:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 08, 2002 10:15 AM
Subject: IDE Patch (fwd)


>
> ---------- Forwarded message ----------
> Date: Sat, 5 Jan 2002 14:17:00 -0500 (EST)
> From: Rob Radez <rob@osinvestor.com>
> To: Andre Hedrick <andre@linux-ide.org>
> Subject: IDE Patch
>
> Hi,
> I'm using your ide.2.4.16.12102001 patch with a Promise PDC20269
> controller and a Maxtor 160GB hard drive on 2.4.17, and I just wanted to
> tell you that it's working great so far.
>
> Thanks for all the great code,
> Rob Radez

It works 100% here too! Even on my old blacklisted drives, and my old BP6
mobo with a buggy HPT366 controller.

No more DMA timeouts
No more Attempts to read beyond the end of disk
No more use of ATA-33 on a drive that cannot handle it

Nice work Andre!

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/U33 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt


