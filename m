Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRAPQ4U>; Tue, 16 Jan 2001 11:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRAPQ4K>; Tue, 16 Jan 2001 11:56:10 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:56080 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S130423AbRAPQ4A>; Tue, 16 Jan 2001 11:56:00 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95193@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Douglas Gilbert'" <dougg@torque.net>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 11:51:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The scsi host numbers will be allocated to the HBAs in 
> the order shown starting at 0. This method does not
> distinguish between the two advansys controllers, luckily
> swapping their positions on the PCI bus does.
	[Venkatesh Ramamurthy]  Just think an end-user fuguring out this!!!!
Asking him to change PCI slots and trying it out. My point is the end user
should not worry about all this. All he does is plugs a new different/ same
type of card, and gets it going. Why should the linux kernel force the user
to change the PCI slots. Will this not make it more user - unfriendly


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
