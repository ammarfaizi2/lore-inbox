Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSDWNsB>; Tue, 23 Apr 2002 09:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSDWNr6>; Tue, 23 Apr 2002 09:47:58 -0400
Received: from firenze.terenet.com.br ([200.255.3.10]:45072 "EHLO
	firenze.terenet.com.br") by vger.kernel.org with ESMTP
	id <S315204AbSDWNr5>; Tue, 23 Apr 2002 09:47:57 -0400
Mime-Version: 1.0
Message-Id: <p05100307b8eb145c44b8@[192.168.2.12]>
Date: Tue, 23 Apr 2002 10:47:43 -0300
To: linux-kernel@vger.kernel.org
From: Luiz Felipe Ceglia <lceglia@terenet.com.br>
Subject: Kernel panic: skput:over: 00146294:4096
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel gurus,

I have a system which was considered very stable until now.

The system is a Compaq ML350 pentium III 733Mhz - 512Mb ram,
running a linux based on RedHat 3.0.3, with kernel 2.0.36.
(I upgraded the daemons, of course)

Suddenly the system started to hang and printing this warning message.


The only thing which happend at our site was an internet link 
upgrade, from 512Kbps to 2Mbps, but this link is attached to an cisco 
router.


Would you have any clue?


Apr 21 21:13:29 ffff kernel: Kernel panic: skput:over: 00146294:4096
Apr 21 22:13:51 ffff kernel: Kernel panic: skput:over: 00146294:4096
Apr 22 09:08:13 ffff kernel: Kernel panic: skput:over: 00146294:4096
Apr 22 12:22:54 ffff kernel: Kernel panic: skput:over: 00146294:4096
Apr 22 13:36:53 ffff kernel: Kernel panic: skput:over: 00146294:4096
Apr 23 09:14:58 ffff kernel: Kernel panic: skput:over: 00146294:4096


-- 
Luiz Felipe Ceglia
lceglia@terenet.com.br 	-  +55-21-9135-3679



