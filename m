Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSKNASW>; Wed, 13 Nov 2002 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKNASW>; Wed, 13 Nov 2002 19:18:22 -0500
Received: from [203.199.93.15] ([203.199.93.15]:23310 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S264716AbSKNASV>; Wed, 13 Nov 2002 19:18:21 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200211140016.FAA31013@WS0005.indiatimes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: different mmap request to the same device driver.
Date: Thu, 14 Nov 2002 05:54:44 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


  I'm writing a character for my PCI based device.


  As per the requirement I need to export couple of base address to the user space.


  I have implemented mmap to achieve this. I'm differentating these two base address with the help of the second parameter, size as these two address spaces vary in size.


  I'd like to know is there any other better way of differentiating both these mmaps.  


Warm Regards


Arun


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

