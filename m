Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbRCKALd>; Sat, 10 Mar 2001 19:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131164AbRCKALY>; Sat, 10 Mar 2001 19:11:24 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:215 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S131163AbRCKALO>;
	Sat, 10 Mar 2001 19:11:14 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AAAC179.8020109@ksu.ru>
Date: Sun, 11 Mar 2001 03:06:17 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: filesystem for initrd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm in the process of creating a custom "system partition"
for out Linux servers, which is actually an initial ramdisk,
coming from hd or network on boot
to load necessary drivers and perform important checks
before the real filesystems get mounted,
and I did not find any info on
what filesystems can I use
for initrd, are there any restrictions?
Mostly interested in cramfs,
due to it's compression.

Could anybody help me work this out or point to the right place for more 
info?

Thanks a lot,
Art.



