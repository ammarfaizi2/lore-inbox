Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSEBTW6>; Thu, 2 May 2002 15:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEBTW5>; Thu, 2 May 2002 15:22:57 -0400
Received: from mcewen.wcnet.org ([63.174.200.22]:51611 "EHLO mcewen.wcnet.org")
	by vger.kernel.org with ESMTP id <S315374AbSEBTW4>;
	Thu, 2 May 2002 15:22:56 -0400
Date: Thu, 2 May 2002 15:24:09 -0400 (EDT)
From: <skmail@mcewen.wcnet.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel strangeness
Message-ID: <Pine.LNX.4.33.0205021516240.4418-100000@mcewen.wcnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all-

I am trying to create a RH 7.2 based system that will run on a read only 
32 meg flash disk.  It is going on a Soekris Net4501 board, which has 3 
ethernets, 64 meg memory, and an AMD Elan SC520.  I loaded the flash disk 
on a full install of RH 7.2.  Custom compiled the kernel for no modules, 
for an i386 architecture.  It works fine on the desktop system I used to 
load it, but when I put it on the net4501,  Lilo loads, starts loading the 
kernel, then it hangs.  The last message on the screen is Freeing unused 
kernel memory.  I also downloaded the latest 2.4.19-pre7, compiled it for 
the Elan processor, with no success.  Same thing happens.  

I'm not sure what the kernel is looking for, why it stops at that 
particular place.  Can anyone help?

TIA

