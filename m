Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbTHaBoK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbTHaBoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:44:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:5347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262391AbTHaBoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:44:07 -0400
Message-ID: <33069.4.4.25.4.1062294245.squirrel@www.osdl.org>
Date: Sat, 30 Aug 2003 18:44:05 -0700 (PDT)
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <papadako@csd.uoc.gr>
In-Reply-To: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With all of the 2.5, 2.6 kernels I have tried(currently 2.6.0-test4-mm3), I
> have problems with my Zip.I can mount and umount it cleanly but when I try
> to write something from it in my disk either cp will just
> segfault or my system will just reboot. Also when I am in KDE it will lockup
> my system and kernel reports the messages that are in the end of the mail.
> Also with hdparm -I /dev/hdd the kernel prints the following message: hdd:
> drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdd: drive_cmd: error=0x04
>
> P.S.
> The Zip works with 2.4 kernels...

What interface on the ZIP 100?  I have parallel, SCSI, USB, or
ZipPlus (imm driver).  Is there another (ATAPI) interface model also?

~Randy



