Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135247AbRDZXCG>; Thu, 26 Apr 2001 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135257AbRDZXB4>; Thu, 26 Apr 2001 19:01:56 -0400
Received: from adsl-63-203-203-138.dsl.snfc21.pacbell.net ([63.203.203.138]:42245
	"EHLO michael.channeldot.com") by vger.kernel.org with ESMTP
	id <S135247AbRDZXBp>; Thu, 26 Apr 2001 19:01:45 -0400
Date: Thu, 26 Apr 2001 16:13:07 -0700 (PDT)
From: Michael Shiloh <mshiloh@mediabolic.com>
To: linux-kernel@vger.kernel.org
Subject: DMA support in cs5530 IDE driver?
In-Reply-To: <86256A3A.007A6C40.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.21.0104261538090.32533-100000@michael.channeldot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone report success or failure with enabling DMA for
the CS5530 IDE driver? I can get my system to crash or at
least hang pretty reliably by using hdparm to turn on DMA
while reading an MPEG-2 movie from my hard disk drive.

The hard disk drive is the only rotating drive on the 
system.

Hardware: GCT Allwell set top box 
CPU: National Geode 266MHz GXM  
IDE controller: CS5530 Geode companion chip
Linux: 2.4.3
Disk: IBM Deskstar, 46.1 GByte

Any comments or suggestions appreciated

Thanks,
Michael

