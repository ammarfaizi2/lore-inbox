Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJZAPL>; Fri, 25 Oct 2002 20:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJZAPL>; Fri, 25 Oct 2002 20:15:11 -0400
Received: from [203.199.93.15] ([203.199.93.15]:39952 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S261723AbSJZAPL>; Fri, 25 Oct 2002 20:15:11 -0400
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200210252354.FAA07091@WS0005.indiatimes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: msync() required?
Date: Sat, 26 Oct 2002 05:18:22 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  We have implemented mmap in our device driver (PCI based controller) to map the device to application space.

  Do we require msync call to make sure whether read//write from/to the device works properly?

Regards
Arun



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

