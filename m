Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289065AbSAGAyc>; Sun, 6 Jan 2002 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSAGAyX>; Sun, 6 Jan 2002 19:54:23 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:58081 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S289062AbSAGAyL>; Sun, 6 Jan 2002 19:54:11 -0500
Message-Id: <5.1.0.14.0.20020107114616.00b9f458@mail.bigpond.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Jan 2002 11:53:58 +1100
To: linux-kernel@vger.kernel.org
From: Dylan Egan <crack_me@bigpond.com.au>
Subject: 2.4.17 - hanging due to usb
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently trying to install my usb-storage device to use with 2.4.17.
I have my usb device connected and switched on so when i do insmod usb-uhci 
or insmod uhci it automatically picks it up and goes to install it but a 
few seconds after its done that, linux just freezes up and i can't do 
anything except reboot via the reboot switch (keyboard does not work). My 
usb is using a shared irq with onboard sound so i disabled sound in the 
BIOS and retried, only to find it failed again. I dont have enough time to 
check for any errors so i can't figure out the problem and when i check the 
logs there seems to be nothing out of the ordinary.

Regards,

Dylan

