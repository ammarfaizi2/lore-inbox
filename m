Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292668AbSBZSud>; Tue, 26 Feb 2002 13:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBZSuV>; Tue, 26 Feb 2002 13:50:21 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:15024 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S292420AbSBZSuR>; Tue, 26 Feb 2002 13:50:17 -0500
Message-ID: <006e01c1bef6$6dd78e40$030ba8c0@mistral>
From: "Simon Turvey" <turveysp@ntlworld.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu>
Subject: Re: IDE error on 2.4.17
Date: Tue, 26 Feb 2002 18:50:15 -0000
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

The drive's less than a year old :-(

Should I try disabling some of the UDMA stuff?

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Simon Turvey" <turveysp@ntlworld.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 26, 2002 6:27 PM
Subject: Re: IDE error on 2.4.17


> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
> > sector=250680
> > end_request: I/O error, dev 03:01 (hda), sector 250680
> 
> Uncorrectable error is a message from your disk, along the lines of "Hey
> pal I wonder if the warranty has expired yet"
> 
> 


