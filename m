Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQLLTkp>; Tue, 12 Dec 2000 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131682AbQLLTkf>; Tue, 12 Dec 2000 14:40:35 -0500
Received: from mh1.lbl.gov ([128.3.7.48]:11661 "EHLO PraetorianGuard.lbl.gov")
	by vger.kernel.org with ESMTP id <S130339AbQLLTkd>;
	Tue, 12 Dec 2000 14:40:33 -0500
Date: Tue, 12 Dec 2000 11:10:05 -0800 (PST)
From: "Stephen J. Gowdy" <gowdy@mh1.lbl.gov>
Reply-To: SGowdy@lbl.gov
To: linux-usb-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: USB (MS Intellimouse specifically) does not work with SMP Linux 2.2.18.
In-Reply-To: <NEBBKCNHIKGLMACGICIGAEFMCAAA.lar@cs.york.ac.uk>
Message-ID: <Pine.OSF.3.95a.1001212110926.2812N-100000@online04.lbl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Have you tried setting MPS to 1.1 in your bios (instead of 1.4)?
This seems to be needed for 2.2.x kernels but not 2.4.x.

							regards,

							Stephen.

--
 /------------------------------+-=-=-=-=-+-------------------------\
|Stephen J. Gowdy               |A4000/040| Mail Stop 50A-2160, LBL, |
|http://www.ph.ed.ac.uk/~gowdy/ | 1GB   HD| 1 Cyclotron Rd, Berkeley,|
|                               |20MB  RAM| CA 94720, USA            |
|InterNet: SGowdy@lbl.gov       |3.4xCDROM| Tel: +1 510 495 2796     |
 \------------------------------+-=-=-=-=-+-------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
