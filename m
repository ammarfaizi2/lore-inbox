Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEONR1>; Wed, 15 May 2002 09:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEONR0>; Wed, 15 May 2002 09:17:26 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:38909 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S314243AbSEONRZ>; Wed, 15 May 2002 09:17:25 -0400
Message-ID: <180577A42806D61189D30008C7E632E87938E1@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'linux-kernel@vger.kernel.org.'" <linux-kernel@vger.kernel.org>
Subject: Device driver question
Date: Wed, 15 May 2002 09:17:21 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am relatively new to Linux (< 6 months). We have designed an embedded
system (on compact PCI) running on a Pentium III 700Mhz cPCI machine. This
machine supports upt to 6 cPCI boards for specific functions (this is our
own HW). I have already written the device drivers for these boards and the
system is running. I have a specific case where our HW can generate a
special interrupt. In this case I simply want the ISR to halt the system
(i.e. take the same action as if I typed halt from the command line). How
can I from within my device driver cause a halt? Please CC me specifically
on any replies.

Thanks in advance. 

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

