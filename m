Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbTAGOPI>; Tue, 7 Jan 2003 09:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267397AbTAGOPI>; Tue, 7 Jan 2003 09:15:08 -0500
Received: from marstons.services.quay.plus.net ([212.159.14.223]:52121 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S267395AbTAGOPH>; Tue, 7 Jan 2003 09:15:07 -0500
From: peter.holmes@fopet-esl.com
To: faye@clara.net
Date: Tue, 7 Jan 2003 14:23:05 -0000
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Reply-to: peter.holmes@fopet-esl.com
CC: linux-kernel@vger.kernel.org
Message-ID: <3E1AE2C9.13240.1114A3C@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Andrew McGregor [andrew@indranet.co.nz] wrote:
>> So *that* is why ACPI kernels are so slow on my laptop (Dell i8k), 
>> and make so much heat. I bet one of those threads ends up busy 
>> looping because of other brokenness.

> Faye Pearson [faye@clara.net] wrote:
> My laptop was a lot happier when I removed the GPE _L00 method from my
> DSDT which was busylooping sending a processor 0x80 event.

As a relative newcomer to LINUX quite a lot of it is a foreign language,
(no awful pun intended).  I've been around electronics and computers for
quite a few years now.  So would you be so kind as to explain just what
is "GPE_L00" and "DSDT".  And just how we remove the salient part?
I have a new Acer Aspire 1304LC which I could cook an egg on.
Windoze(2K & XP Pro) don't generate anything like so much warmth.

Peter
