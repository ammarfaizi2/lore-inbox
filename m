Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRBFC0W>; Mon, 5 Feb 2001 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRBFC0M>; Mon, 5 Feb 2001 21:26:12 -0500
Received: from smtp.sunflower.com ([24.124.0.137]:37901 "EHLO
	smtp.sunflower.com") by vger.kernel.org with ESMTP
	id <S129501AbRBFC0B>; Mon, 5 Feb 2001 21:26:01 -0500
From: "Steve 'Denali' McKnelly" <denali@sunflower.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Motherboard Misdetect
Date: Mon, 5 Feb 2001 20:25:11 -0600
Message-ID: <PGEDKPCOHCLFJBPJPLNMMEKHCBAA.denali@sunflower.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14Pk6B-00039b-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy Alan,

	I won't disagree with what you and David are saying.  I
	took a look at the picture of the 6KD, and they're similar.
	Main difference is missing SCSI connectors and an extra long
	PCI slot (on the 6KD).

	Thanks!

Steve

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, February 05, 2001 5:46 AM
To: Steve 'Denali' McKnelly
Cc: linux-kernel@vger.kernel.org
Subject: Re: Motherboard Misdetect


> 	I own a M-Technology M-668DS motherboard.  Linux 2.4.1
> 	identifies my board as a Soyo SY-6KD.  They're not really
> 	the same board, and they each have features the other doesn't

We read the data from the BIOS. Its actually only scanned to match against
known system bugs so won't be a problem. It sounds like they are using the
same bios image on a set of boards and didnt bother to fix the name.

It may well also be they are the same board minus a few components.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
