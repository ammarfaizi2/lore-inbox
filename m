Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285879AbRLHImL>; Sat, 8 Dec 2001 03:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285878AbRLHImB>; Sat, 8 Dec 2001 03:42:01 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:23488 "HELO smeg")
	by vger.kernel.org with SMTP id <S285879AbRLHIlq>;
	Sat, 8 Dec 2001 03:41:46 -0500
From: "Lee Packham" <lpackham@mswinxp.net>
To: <linux-kernel@vger.kernel.org>
Subject: Support of sonypi module/code
Date: Sat, 8 Dec 2001 08:40:30 -0000
Message-ID: <000001c17fc3$fe666c00$0102a8c0@lee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I going to be treading on anybody's toes if I release a patch for the
sonypi module to add battery and AC power information support?

The reason is thus, to stop the fan spinning all the time on my laptop I
have to use ACPI (I have a Vaio FX-103). It doesn't work great, but it
works...

ACPI can't report battery info. Nor can APM!

You have to use the Programmable Interrupts thing to get them out of the
system. I wrote a program that did this (vaiod) on a polling interval to
set my screen brightness automagically but I would have to poll things
manually. It would be great to do this though /dev/sonypi.

It doesn't look like the code has been updated for ages. So is anybody
going to complain if I do it?

Lee Packham


