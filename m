Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282829AbRLKVBs>; Tue, 11 Dec 2001 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283488AbRLKVBj>; Tue, 11 Dec 2001 16:01:39 -0500
Received: from 210-86-49-187.jetstart.xtra.co.nz ([210.86.49.187]:2688 "EHLO
	albatross.hisdad.org.nz") by vger.kernel.org with ESMTP
	id <S283694AbRLKVBV>; Tue, 11 Dec 2001 16:01:21 -0500
Subject: [2.4.16 bug] Major failure
From: John Huttley <john@mwk.co.nz>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 10:01:15 +1300
Message-Id: <1008104476.1373.0.camel@albatross.hisdad.org.nz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to those who have replied.

The video card is a GA-660, which is a TNT2 using the Xfree driver.

I no longer have any old kernels on my system.
I've never tried using more than one compiler, so I'll put
that suggestion in the 'too hard' basket for the moment.



I have tried a 2.4.17-pre8 kernel with power management switched off.
There were no problems with this! It works just fine.


I subsequently tried a kernel with the ACPI drivers compiled in.
The system booted ok, but rather coming up with gdm, it gave
a part lit screen with no visible raster.

It did not respond to the keyboard, however I was able to ssh into it.
gdm and X were running. And i was able to shutdown. Even then the
display did not clear until i reset it.

I will try some more combinations tonight. A UP build+ACPI and a
runlevel 3 version. If I can characterise it, I'll try to get some old
kernels.

I am not on the list, please cc' any replies.
Regards
John




