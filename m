Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280038AbRJaCvr>; Tue, 30 Oct 2001 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280039AbRJaCv2>; Tue, 30 Oct 2001 21:51:28 -0500
Received: from oe36.law11.hotmail.com ([64.4.16.93]:5640 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280038AbRJaCvX>;
	Tue, 30 Oct 2001 21:51:23 -0500
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: <bos@serpentine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133 data corruption update
Date: Sun, 28 Oct 2001 18:50:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE362uJCzcihwZnH34u00018722@hotmail.com>
X-OriginalArrivalTime: 31 Oct 2001 02:51:55.0363 (UTC) FILETIME=[00377B30:01C161B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

I have an A7V-133 motherboard, and the VIA IDE just started to work finally,
after upgrading my BIOS to 1007, the latest one, which came out on the same
day as your 1009.  I never experienced "data corruption" as you described,
just irq timeouts which crashed fatally.  It seems like everything is normal
now, in other words, I could install Mandrake 8.1 with no problems whereas
it failed dozens of times before.  There was one other I did different this
time, and that was that I created the partitions in Partition Magic 7.0 for
Windows instead of using DiskDrake.  I can't see this would have any bearing
on things, so I can only attribute the recent successful install to ASUS's
new BIOS.

David Grant

On Saturday October 27, Bryan O'Sullivan said:
>
>After several months of begrudgingly putting up with my ASUS A7V
>motherboard corrupting roughly 1 byte per 100 million read during
>moderate to heavy PCI bus activity, I flashed VIA's 1009 BIOS this
>evening.
>
>I have not been able to reproduce any corruption since then (it was
>ridiculously easy before the new BIOS), and my machine seems otherwise
>as stable as I would hope. This marks the first time since 2.4.6 that
>I've been able to run a Linus kernel without cowering.
>
