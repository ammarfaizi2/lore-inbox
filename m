Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQLRTk7>; Mon, 18 Dec 2000 14:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQLRTky>; Mon, 18 Dec 2000 14:40:54 -0500
Received: from [204.154.204.233] ([204.154.204.233]:17170 "EHLO
	ocean.metricom.com") by vger.kernel.org with ESMTP
	id <S129781AbQLRTk3>; Mon, 18 Dec 2000 14:40:29 -0500
Message-ID: <A8D6FAF7E44BD411A31E0004AC4CB0F6334AD0@planet.metricom.com>
From: "Jain, Jayant" <jjain@metricom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Jain, Jayant" <jjain@metricom.com>
Subject: problem with wireless pcmcia modem with linux (Ricochet)
Date: Mon, 18 Dec 2000 11:10:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Ive been working on getting the wireless modem from novatel work with my
linux box.
I see that all incoming ip packets larger than 450 bytes get corrupted ..the
last two bytes (checksum) goes missing when it reaches the ppp driver..
if the packet is less than that (450 bytes ) everything is fine .
Ive not been able to isolate the problem to the card or the serial driver
The  card works very well with windows and mac

Im using kernel 2.2.16 with pcmcia version 3.1.8 

thanks

jayant jain


please cc me at 

jjain@metricom.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
