Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRKFQLY>; Tue, 6 Nov 2001 11:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279243AbRKFQLP>; Tue, 6 Nov 2001 11:11:15 -0500
Received: from oe57.law10.hotmail.com ([64.4.14.192]:33553 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S279722AbRKFQLB>;
	Tue, 6 Nov 2001 11:11:01 -0500
X-Originating-IP: [64.217.72.217]
From: "Sage" <sage@gypsycaravan.org>
To: <linux-kernel@vger.kernel.org>
Subject: HomePNA 2.0 driver source
Date: Tue, 6 Nov 2001 10:12:46 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE57ZTj0Lcof3GlZudb000035de@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2001 16:10:55.0871 (UTC) FILETIME=[9D76F8F0:01C166DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if this has been posted before... I just subscribed to this list
today.  I've noticed while reading archives of this list online that some
people have been requesting drivers for the newest HomePNA network card
drivers.  The older cards which operate at 1 Mbps are supported, but drivers
for version 2.0 of HomePNA, featuring the Broadcom 4210 chip and operating
at 10 Mbps, have been unavailable until recently.

Shawn Starr posted the following link here about a month ago:
ftp://ftp.linksys.com/beta/linux_full_binary_2_33.exe

That link will get you binary only drivers.  However, I poked my nose onto
that FTP server and found the following:

ftp://ftp.linksys.com/beta/linux_hpna2_0_v2_34_0_2.exe

This file contains at least partial source code for the driver, not to
mention a slightly newer version.

Since it's chipset-oriented, I expect it should work on ALL HomePNA cards,
such as the Diamond HomeFree and NetGear cards, not just the LinkSys.

I haven't tested these yet, but I will in the next couple of days.  I know
nothing about driver hacking - I'm posting this here because I've seen
people asking here for drivers and because I want the word to get out.
Frustrating when you can't find linux drivers for something, y'know?

Sorry for the bother, but I hope someone finds these useful. :)

Sage
