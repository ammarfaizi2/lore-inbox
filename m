Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272510AbRIOVbb>; Sat, 15 Sep 2001 17:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272508AbRIOVbW>; Sat, 15 Sep 2001 17:31:22 -0400
Received: from [206.168.99.80] ([206.168.99.80]:31248 "HELO ns1.tcsitalia.it")
	by vger.kernel.org with SMTP id <S273080AbRIOVbG>;
	Sat, 15 Sep 2001 17:31:06 -0400
Message-Id: <5.1.0.14.2.20010915232738.00a90ba0@mail.tcsitalia.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 15 Sep 2001 23:39:57 +0200
To: linux-kernel@vger.kernel.org
From: Johnny Mnemonic <johnny@themnemonic.org>
Subject: kernel 2.4.* hangs just after uncompressing image
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,
I'm currently running kernel 2.2.19 fine, and I'd need to upgrade to 2.4 
shortly, but after a careful configuration when i try to boot it hangs just 
after the message "Ok, booting kernel .."

As far as i know the problem verifies with each version of the 2.4 kernel, 
and i think that it is an hardware problem.

I'm not able to trace the operations because part of the startup code is in 
assembly.
The cpu is a Pentium Celeron 166 with 32Mb of RAM.
If you can address me about what may cause the problem i can be more 
detailed about that.

Any hint will be appreciated

-John

