Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSHMKGt>; Tue, 13 Aug 2002 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSHMKGt>; Tue, 13 Aug 2002 06:06:49 -0400
Received: from [203.199.83.245] ([203.199.83.245]:25311 "HELO
	mailweb33.rediffmail.com") by vger.kernel.org with SMTP
	id <S314284AbSHMKGs>; Tue, 13 Aug 2002 06:06:48 -0400
Date: 13 Aug 2002 10:09:56 -0000
Message-ID: <20020813100956.2082.qmail@mailweb33.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: RealTek RTL8139C
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for disturbing the list again.

I am using RTL8139C in our target board which is based on MIPS 
IDT32334 processor.

The version of 8139too.c that i am using is 1.0.1 where as I am 
using a embedded linux which is based on Linux Kernel 
2.4.5-pre1.

When the packet is transmitted out, it is coming out as all 
0's(captured using sniffer). I dumped the whole packet in 
rtl8139_start_xmit (). The packet is a valid ARP packet.

My doubt is whether this 8139too.c is tested with MIPS processors? 
Because in one of the article i found that the supported 
processors are ARM, i386 etc.

Can any body throw some light on this?

with best regards,
Nanda
