Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263657AbRFDT71>; Mon, 4 Jun 2001 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263724AbRFDT7S>; Mon, 4 Jun 2001 15:59:18 -0400
Received: from comverse-in.com ([38.150.222.2]:20980 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S263692AbRFDT7C>; Mon, 4 Jun 2001 15:59:02 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F1C@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'jalaja devi'" <jala_74@yahoo.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: RE: Error Compiling Driver code:
Date: Mon, 4 Jun 2001 15:58:07 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Check the FAQ - http://www.tux.org/lkml/#s8
2) RH6.2 as it is doesn't come with all the newest tools versions needed for
the 2.4.x kernels. See Documentation/versions.

HTH,
	Vassilii
> -----Original Message-----
> Hi ,
> I am trying to compile a driver code in Red Hat 6.2
> which is already a working code, but I get the
> following errors when i compile. 
> 
> /usr/src/linux/include/asm/smp.h:206: arguments given
> to macro `hard_smp_processor_id'
> 
[snip]
> Please read the FAQ at  http://www.tux.org/lkml/
