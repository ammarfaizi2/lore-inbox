Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278336AbRJ1NLW>; Sun, 28 Oct 2001 08:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJ1NLN>; Sun, 28 Oct 2001 08:11:13 -0500
Received: from f266.law9.hotmail.com ([64.4.8.141]:25865 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S278315AbRJ1NKx>;
	Sun, 28 Oct 2001 08:10:53 -0500
X-Originating-IP: [213.1.168.246]
From: "Solid Silver Panther" <silverpanther50@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.13 freezes on boot
Date: Sun, 28 Oct 2001 13:11:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F266tyCEyjWk9UlwaM30001198e@hotmail.com>
X-OriginalArrivalTime: 28 Oct 2001 13:11:24.0453 (UTC) FILETIME=[0B7B4550:01C15FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greetings all,

  I apologise for the somewhat vague descriptions here, but Im no 
experienced Kernel Hacker. I'm in my 3rd month of Linux (RedHat 7.1) and was 
disappointed by the lack of my USB devices (printer and scanner and 
keyboard). I managed to replace the keyboard for PS/2 one. So, i decided to 
upgrade kernel to 2.4.13.

The USB Support I built in is now killing my PC.

usb.c: Registered new driver iforce

Thats my last boot message before the system freezes, so Im guessing 2.4.13 
doesnt properly support the USB stuff I have.

If theres a fix for that, or if its a common problem that everyone building 
USB support into their kernels has, I'd appreciate knowing in either case. 
If it is something im doing hiddeously wrong, please feel free to shout at 
me.

Thanx all.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

