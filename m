Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132311AbRA0UBD>; Sat, 27 Jan 2001 15:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135381AbRA0UAs>; Sat, 27 Jan 2001 15:00:48 -0500
Received: from shomer.lee.k12.nc.us ([207.4.71.118]:28938 "EHLO lee.k12.nc.us")
	by vger.kernel.org with ESMTP id <S132311AbRA0UAe>;
	Sat, 27 Jan 2001 15:00:34 -0500
From: "Ryan Hairyes" <rhairyes@lee.k12.nc.us>
To: <linux-kernel@vger.kernel.org>
Date: Sat, 27 Jan 2001 20:58:51 +0000 (GMT)
Organization: Lee County Schools
X-Mailer: ObsidianSystems-OcsEmail1-0-30 brewed at www.obsidian.co.za
Reply-to: rhairyes@lee.k12.nc.us
Message-ID: <98062913115550-27145815550rhairyes@lee.k12.nc.us>
Subject: kernel boot problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I was wondering if someone might be able to help me.
I have just compiled my kernel and set it up on a floppy
to boot off a disk.  I have it then use an image file to uncompress
and get the filesystem off ,etc.  Well when it boots it says it has
uncompressed the filesystem image and then gives me this:
Mounted Root (ext2 filesystem) readonly
Freeing unused kernel memory: 212K freed
Warning: unable to open an initial console
Kernel panic: no init found. Try passing init= option to the kernel.

I know that I have init on the image, so what could I be doing wrong.
It is probably something stupid that I am overlooking, but I thank you in
advance.
              
Ryan                     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
