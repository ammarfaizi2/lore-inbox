Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132021AbRAPQgA>; Tue, 16 Jan 2001 11:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAPQfv>; Tue, 16 Jan 2001 11:35:51 -0500
Received: from nposte09.axime.com ([160.92.113.114]:44246 "EHLO
	mail.laposte.net") by vger.kernel.org with ESMTP id <S129831AbRAPQfb>;
	Tue, 16 Jan 2001 11:35:31 -0500
Message-ID: <000e01c07fd8$a90d0480$6115a8c0@dev2>
Reply-To: "Florent Cueto" <fcueto@wanadoo.fr>
From: "Florent Cueto" <florent.cueto@laposte.net>
To: "Venkatesh Ramamurthy" <Venkateshr@ami.com>,
        "'David Woodhouse'" <dwmw2@infradead.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518D@ATL_MS1>
Subject: Re: Linux not adhering to BIOS Drive boot order? 
Date: Tue, 16 Jan 2001 17:23:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Florent Cueto
Java developer
Socks via HTTP Homepage : http://www.javawork.net
(A program to tunnel socks requests via HTTP).

----- Original Message -----
From: "Venkatesh Ramamurthy" <Venkateshr@ami.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>; "Venkatesh Ramamurthy"
<Venkateshr@ami.com>
Cc: <linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>; "'Alan
Cox'" <alan@lxorguk.ukuu.org.uk>
Sent: Tuesday, January 16, 2001 5:19 PM
Subject: RE: Linux not adhering to BIOS Drive boot order?


> > It should be possible to read the BIOS setting for this option and
> > behave accordingly. Please give full details of how to read and
interpret
> > the information stored in the CMOS for all versions of AMI BIOS, and
I'll
> > take a look at this.
> [Venkatesh Ramamurthy]  When i meant BIOS setting option i meant the
> SCSI BIOS settings not system BIOS option. The two SCSI controllers are of
> different make. This situation is made worse when the system has many
cards
> of different makes and one of the controller somewhere in the middle of
all
> the slots is made the boot controller.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
