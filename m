Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKYMyI>; Sat, 25 Nov 2000 07:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131090AbQKYMx5>; Sat, 25 Nov 2000 07:53:57 -0500
Received: from limes.hometree.net ([194.231.17.49]:55332 "EHLO
        limes.hometree.net") by vger.kernel.org with ESMTP
        id <S129228AbQKYMxy>; Sat, 25 Nov 2000 07:53:54 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 25 Nov 2000 12:10:24 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8voa7g$d1r$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <3A1EEFC8.16A48C24@its.caltech.edu>, <Pine.LNX.4.10.10011241734310.4479-100000@master.linux-ide.org>
Reply-To: hps@tanstaafl.de
Subject: Re: Fasttrak100 questions...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andre@linux-ide.org (Andre Hedrick) writes:

>NO!

>Doing so VIOLATES the terms and agreement that you obtained the BINARY
>Soft-Raid Engine and the GPL terms of the kernel.

>On Fri, 24 Nov 2000, James Lamanna wrote:
[...]
>> The question is, is there a way to compile this module into the kernel
>> so that it will automatically detect the card? A simple linking of the
>> module into the scsi library by editing the Makefile doesn't seem to do
>> it. It doesn't detect the drives if I boot off of a floppy with this
>> kernel on it.
[...]

No, it does not. Distributing does. You will never get this right. You
can compile into your kernel anything you like as long as you don't
give it away.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
