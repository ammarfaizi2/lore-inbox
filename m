Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143377AbREKT5r>; Fri, 11 May 2001 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143376AbREKT5h>; Fri, 11 May 2001 15:57:37 -0400
Received: from zeus.kernel.org ([209.10.41.242]:19341 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S143372AbREKT5T>;
	Fri, 11 May 2001 15:57:19 -0400
Message-ID: <007d01c0da4e$6f37b540$d539e195@boeblingen.de.ibm.com>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: <kernel@llamas.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14yHQW-0001Sg-00@the-village.bc.nu>
Subject: Re: Latest on Athlon Via KT133A chipset solution?
Date: Fri, 11 May 2001 21:12:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Give the current -ac a spin and tell me if it works/doesnt and if not how
> it fails

I will test it on Sunday evening, when I get back access to my Athlon.

Again I am not sure if I had the same problem related to the
compiler-optimizations. My problems (system freeze) started with 2.4.3-ac7.
So the problem might related to the VIA-bug-workaround.

Is there a possibility to get debugging messages or register dumps without a
second PC? Or is there a possibility to an unbuffered log write? e.g. write
kernel logs to a floppy disc unbuffered. Otherwise I am not sure, if I am
able to help you finding the problem.
Unfortunately I have only a VIA-based Athlon system and not a S/390

greetings

Christian Bornträger





