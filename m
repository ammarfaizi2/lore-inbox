Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131891AbRAPQYK>; Tue, 16 Jan 2001 11:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAPQYB>; Tue, 16 Jan 2001 11:24:01 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:10509 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129675AbRAPQX5>; Tue, 16 Jan 2001 11:23:57 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E9518D@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux not adhering to BIOS Drive boot order? 
Date: Tue, 16 Jan 2001 11:19:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It should be possible to read the BIOS setting for this option and
> behave accordingly. Please give full details of how to read and interpret
> the information stored in the CMOS for all versions of AMI BIOS, and I'll
> take a look at this.
	[Venkatesh Ramamurthy]  When i meant BIOS setting option i meant the
SCSI BIOS settings not system BIOS option. The two SCSI controllers are of
different make. This situation is made worse when the system has many cards
of different makes and one of the controller somewhere in the middle of all
the slots is made the boot controller. 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
