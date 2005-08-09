Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVHIML0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVHIML0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 08:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVHIML0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 08:11:26 -0400
Received: from [202.125.86.130] ([202.125.86.130]:54448 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S932505AbVHIMLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 08:11:25 -0400
Subject: RE: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Date: Tue, 9 Aug 2005 17:41:25 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <C349E772C72290419567CFD84C26E01709FE9C@mail.esn.co.in>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Thread-Index: AcWUQ5eUBWmJXYK1SQ6wxXaIm8pJawIlntBA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

No, the TI PCI 7x21 provides IDE like interface.
However, that is NOT the point here?

I just want to know what could be the problem in mounting a SD card
Formatted in the camera while it is mounting on windows (same HW).

Regards,
Mukund Jampala

>> Execute linux `fdisk` on the device. You may find that the
>> ID byte is wrong.
>>
>> Also, why do you need a special block device driver? The SanDisk
>> and CompacFlash devices should look like IDE drives.
>
>SD usually is secure digital (MMC compatible somewhat I believe).  It
>does not provide IDE unlike CompactFlash.  SD uses a serial interface
if
>I remember correctly.
>
>Len Sorensen



>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
