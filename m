Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRBZTzd>; Mon, 26 Feb 2001 14:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRBZTzX>; Mon, 26 Feb 2001 14:55:23 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:50148 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129780AbRBZTzG>; Mon, 26 Feb 2001 14:55:06 -0500
Message-Id: <5.0.2.1.2.20010226115140.0265f4f8@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Feb 2001 11:53:07 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: ide / usb problem
In-Reply-To: <E14X1f7-00033Q-00@the-village.bc.nu>
In-Reply-To: <20010225060326.K127@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:56 PM 2/25/2001 +0000, Alan Cox wrote:
> > hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
> > ide0: reset: success
> >
> > Again, if it's really a cable problem, then ASUS is selling
> > cables that don't work with UDMA66 (but they sell it as
> > UDMA66).
>
>To get ATA66 working well you need the right cables, you also need a machine
>that is to spec on interference and the like. You cant just point at the 
>cables
>althoigh they are first guess.
>

I have a similar setup and had the same problems.  Dump your cables and get 
ATA/100 Certified cables and you should not have this problem.  Also keep 
the cable length in mind.  Anybody out there know if there's a max cable 
length for the ATA/100 spec??


>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


