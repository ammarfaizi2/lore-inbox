Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131790AbQLPMDg>; Sat, 16 Dec 2000 07:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131815AbQLPMD0>; Sat, 16 Dec 2000 07:03:26 -0500
Received: from ginaz2.justnet.com ([64.245.23.10]:265 "EHLO ginaz2.justnet.com")
	by vger.kernel.org with ESMTP id <S131790AbQLPMDP>;
	Sat, 16 Dec 2000 07:03:15 -0500
Message-Id: <5.0.0.25.2.20001216051043.00a6b008@mail.ricis.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Sat, 16 Dec 2000 05:32:51 -0600
To: Linux Kernel <linux-kernel@vger.kernel.org>
From: Lee Leahu <lee@ricis.com>
Subject: Re: Kernel panic: VFS: LRU block list corrupted
In-Reply-To: <20001216120842.A1851@khan.acc.umu.se>
In-Reply-To: <5.0.0.25.2.20001215205029.00a8a688@mail.ricis.com>
 <5.0.0.25.2.20001215205029.00a8a688@mail.ricis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to David Weinehall's reply:

sorry - i forgot that i needed to include more info, i'm new to mailling lists.

We recently upgraded our server to kernel 2.2.16 because there was a bug in 
2.2.14
and the new sendmail required at least 2.2.16.

We built our computer from Abit BE6-II motherboards, Pentium III 550 MHz, 
512Kb cache,
256 Megs ram,  3com 905c nics, 3dfx Vodoo 3 3000 video cards
maxtor 30G hard drive,  standard floppy drive, decend CD-ROM drive

i'm not very familiar with klog, but i'll go with klogd.
do i append a '-x' to the line that calls klogs in the startup scripts or
is there some other better way of preventing klogd from destroying
the Oops information.

Then i guess ksymoops. decodes the oops info

Lee Leahu
System Administrator
lee@ricis.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
