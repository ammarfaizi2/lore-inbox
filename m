Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVHRNDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHRNDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVHRNDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:03:07 -0400
Received: from [202.125.80.34] ([202.125.80.34]:32981 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932212AbVHRNDH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:03:07 -0400
Content-class: urn:content-classes:message
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 18 Aug 2005 18:26:52 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3887@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWifN8iygSSRApeTDeypuJdotG94QBdzMyg
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lennart,

The USB device I have bought is yet to be tested.
I will do it tomorrow. I was busy in figuring out more on this END. Let
me try it to night.
If not I will try it in the tomorrow day time schedule.

Regards,
Mukund Jampala

>> I have bought a "entermultimedia" USB 2.0 21-in-1 card.
>> There are no Linux driver support in the CD  provided.
>> Can u suggest me what is best bug (USB card reader) with Linux driver
>> support in the Market.
>
>Load usb drivers and usb-storage driver and scsi disk module (sd_mod).
>Then it should show up as a scsi disk.  No modern OS requires drivers
>added for usb drives.  They are just included.
>
>Len Sorensen
