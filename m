Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273230AbRI0PF0>; Thu, 27 Sep 2001 11:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273233AbRI0PFH>; Thu, 27 Sep 2001 11:05:07 -0400
Received: from [200.248.92.2] ([200.248.92.2]:58120 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S273210AbRI0PE7>; Thu, 27 Sep 2001 11:04:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.10 /proc/partitions
Date: Thu, 27 Sep 2001 12:02:51 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01092712025100.01050@dpd16>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I'm testing Linux Kernel 2.4.10. I have a Dell 8450 with 8xP-III 700Mhz, 
10GBytes RAM, with megaraid PERC 3/DC. I have one logic disk (sda) with 4 
partitions (sd1, sd2, sd3, sd4). After boot, my /proc/partitions has this 
values:



 major minor  #blocks  name

   8     0   17692672 sda
   8     1      32098 sda1
   8     2      32130 sda2
   8     3    4096575 sda3
   8     4   13526730 sda4
   8     0   17692672 sda
   8     1      32098 sda1
   8     2      32130 sda2
   8     3    4096575 sda3
   8     4   13526730 sda4
   8     0   17692672 sda
   8     1      32098 sda1
   8     2      32130 sda2
   8     3    4096575 sda3
   8     4   13526730 sda4
   8     0   17692672 sda
   8     1      32098 sda1
   8     2      32130 sda2
   8     3    4096575 sda3
   8     4   13526730 sda4

the cat command never stop to list.



What's happen?




Thank's


Andre
