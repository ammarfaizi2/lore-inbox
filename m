Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbQKFVka>; Mon, 6 Nov 2000 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130074AbQKFVkV>; Mon, 6 Nov 2000 16:40:21 -0500
Received: from nmail.corel.com ([209.167.40.11]:2218 "EHLO nsmail.corel.com")
	by vger.kernel.org with ESMTP id <S129758AbQKFVkJ>;
	Mon, 6 Nov 2000 16:40:09 -0500
Message-ID: <3A07255D.24AAAA70@corel.com>
Date: Mon, 06 Nov 2000 16:40:45 -0500
From: Richard Rak <richardr@corel.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.0-test9
In-Reply-To: <Pine.LNX.3.95.1001106162033.212A-100000@chaos.analogic.com>
Content-Type: multipart/mixed;
 boundary="------------B5182A343CA437BDD16DAEC0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B5182A343CA437BDD16DAEC0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

	I don't have any problems building initrd images here (using
RAMDISKs).  Can I take a look at your scripts and see what is going on?

"Richard B. Johnson" wrote:
> 
> Linux 2.4.0-test9 can be built and booted via initrd when running
> a 2.2.17 kernel.
> 
> However when running, the new kernel 2.4.0-test9, can't be used to
> make a usable initrd ram disk. The result being that 2.4.0-test9
> can't, itself, build an "initrd" bootable system.
> 
> Before everybody screams that I don't know what I'm doing, let me
> assure you that I know that the two kernels put their modules in
> different directories and the new directory scheme seems to require
> the latest and greatest version of modutils.
> 
> I have two ways of building an initial RAM disk (they both use
> scripts, not provided with any distribution). One uses the loop-device
> and the other uses the RAM disk directly. Because of previous
> problems, on some kernel versions, with the loop device (it was
> being mucked with for encription), I exclusively use the RAM disk
> to build initrd.
> 
> Therefore, the problem seems to be that 2.4.0-test9 has a problem
> with the RAM Disk.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
	Richard Rak
	(richardr@corel.com)
	Software Engineer
	A+ Certified Service Technician

	New Team - Renewed Focus:  Corel ushers in a new era!
	To learn more, please visit http://www.corel.com
--------------B5182A343CA437BDD16DAEC0
Content-Type: text/x-vcard; charset=us-ascii;
 name="richardr.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Richard Rak
Content-Disposition: attachment;
 filename="richardr.vcf"

begin:vcard 
n:Rak;Richard
tel;cell:(613) 298-3229
tel;work:(613) 728-0826 ext 1104
x-mozilla-html:FALSE
org:Corel Corporation
adr:;;1600 Carling Ave.;Ottawa;Ontario;K1Z 8R7;Canada
version:2.1
email;internet:richardr@corel.com
title:Software Engineer
x-mozilla-cpt:;-27232
fn:Richard Rak
end:vcard

--------------B5182A343CA437BDD16DAEC0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
