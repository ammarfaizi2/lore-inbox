Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbSK3Oqy>; Sat, 30 Nov 2002 09:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbSK3Oqy>; Sat, 30 Nov 2002 09:46:54 -0500
Received: from [213.140.2.50] ([213.140.2.50]:42942 "EHLO
	mailres.fastwebnet.it") by vger.kernel.org with ESMTP
	id <S267254AbSK3Oqx>; Sat, 30 Nov 2002 09:46:53 -0500
Message-Id: <5.1.1.5.2.20021130152506.02922d50@popmail.iol.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 30 Nov 2002 15:47:25 +0100
To: jsimmons@infradead.org
From: Alberto Ornaghi <alor@iol.it>
Subject: [2.5.50] problems with framebuff and vesafb
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I enable the CONFIG_VIDEO_SELECT option  and the I pass the vga=791 thru 
LILO, I cannot see any message while the kernel boots and while 
running.  the kernel is live, the only problem is that the video seems 
turned off. (I can blindly log in the system and type a reboot)

I suppose this is a regression since my 2.4.20 is working fine with that 
option and I can use my 1024x768 framebuffer console.

I have an S3 savage twister-K, and since there isn't a native driver for 
it, I'm using the vesafb driver.

do you need more info ?

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.

