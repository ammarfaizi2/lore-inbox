Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSFBXB1>; Sun, 2 Jun 2002 19:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317226AbSFBXB1>; Sun, 2 Jun 2002 19:01:27 -0400
Received: from [62.70.58.70] ([62.70.58.70]:49609 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317223AbSFBXB0>;
	Sun, 2 Jun 2002 19:01:26 -0400
Date: Mon, 3 Jun 2002 01:01:23 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: <roy@mail.pronto.tv>
To: <linux-kernel@vger.kernel.org>
cc: <linux-raid@vger.kernel.org>, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: RAID-6 support in kernel?
Message-ID: <Pine.LNX.4.33.0206030044270.27651-100000@mail.pronto.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I'n working on server setup with some 16 disks in RAID-5; one of them a 
spare. After a little reading, I find myself longing for support for 
RAID-6 support in kernel, giving the opportunity to allow for two failed 
drives without a chrash (see links about RAID-6 below if interested).

I am aware of that not all kernel hackers like such configurations, and
that some will rather see small RAID-configurations connected with VLM.  
I beleive there is a reason for using RAID-6, and RAID-controller vendors
(such as Compaq) are already using them, so why shouldn't linux do so
also? With a high number of cheap IDE drives, the chance of one failing is 
quite high, so why not RAID-6? At least for a system doing most reads...

thanks

roy

RAID-6 layout: http://www.acnc.com/04_01_06.html

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

