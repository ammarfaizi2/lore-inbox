Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281395AbRKLKQ1>; Mon, 12 Nov 2001 05:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281394AbRKLKQS>; Mon, 12 Nov 2001 05:16:18 -0500
Received: from gorilla.mchh.siemens.de ([194.138.158.18]:8592 "EHLO
	gorilla.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S281392AbRKLKQK>; Mon, 12 Nov 2001 05:16:10 -0500
Message-ID: <4D486782CA36D4118A530000D11EA42A143E04@blns204e.bln.icn.siemens.de>
From: Graf Holger <Holger.Graf@icn.siemens.de>
To: "'David Grant'" <davidgrant79@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Athlon cooling
Date: Mon, 12 Nov 2001 11:15:43 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look for LVCool.

http://www.naggelgames.de/vcool/VC_Linux.html

If you have ACPI enabled you can comment out lvcool's idle loop.

Holger
______________________________________________________________________
User error! Please replace user and hit any key to continue...

Disclaimer: My opinions are entirely my own I was assured.
Holger.Graf@icn.siemens.de

> -----Original Message-----
> From:	David Grant [SMTP:davidgrant79@hotmail.com]
> Sent:	Friday, November 09, 2001 3:19 AM
> To:	linux-kernel@vger.kernel.org
> Subject:	Athlon cooling
> 
> There is a program for Windows called CPUIdle, which cools the Athlon
> tremendoulsy.  I can get my temp. from 52C down to 36C.  It makes the CPU
> truly go idle.  Is there anything like this for Linux, and I'm wondering if
> anyone knows the instructions (and/or signals) which could be used to put
> the Athlon into this state.  I guess it's more of a question for some APM
> guys, but I thought some people here might know the interface to the Athlon,
> and might thus know how this software cooling works.  Actually the low-level
> apm stuff is part of the kernel right?  so maybe this is on-topic.
> 
> http://www.cpuidle.de/
> 
> Cheers,
> David Grant
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
