Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHKGpZ>; Sun, 11 Aug 2002 02:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSHKGpY>; Sun, 11 Aug 2002 02:45:24 -0400
Received: from kiln.isn.net ([198.167.161.1]:47523 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S317772AbSHKGpY>;
	Sun, 11 Aug 2002 02:45:24 -0400
Message-ID: <3D56088C.37A2B574@isn.net>
Date: Sun, 11 Aug 2002 03:47:40 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-rc5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamey.hicks@hp.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: new driver: multimedia card (mmc) framework, patch against 2.4.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,
I am currently using an MMC card via usb with a SanDisk SDDR-33 reader.
I can use either MMC cards or SD cards using the sddr09 driver in
usb/storage. All I had to do was mount -t msdos /dev/sda1 /mnt. But your
post sent me scurrying through that code and I looked at unusual_devs.h
and noticed that sddr-33 was not mentioned, but sddr-31, -09 etc were.
 I'd love to have an MMC slot in place of my floppy drive.
Garst

not subcribed
