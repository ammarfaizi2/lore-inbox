Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265632AbSJSRNn>; Sat, 19 Oct 2002 13:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSJSRNn>; Sat, 19 Oct 2002 13:13:43 -0400
Received: from [203.199.93.15] ([203.199.93.15]:21009 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S265632AbSJSRNl>; Sat, 19 Oct 2002 13:13:41 -0400
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200210191654.WAA24415@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: mmap doubts
Date: Sat, 19 Oct 2002 22:18:24 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  As per our requirement, we are exporting the hardware personalities (Base Addresses) to the user space by implementing mmap(). (We write device driver for application specific PCI based controllers)

  I would like to know how mmap() works actually. I meant the flow, address translations, etc.

  Will there be any cache problem, if we use mmap()?

  I also want to know how ring 3 and ring 0 matters in mmap() as we export ring 0 address to user space (ring 3). ( we work on intel platform). 

Will there be any time delay if we use mmap() and access hardware in the user space?

  It would be helpful, if you any one of you could explain/answer my doubts.

  Have a nice time.

Warm Regards

Arun




Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

