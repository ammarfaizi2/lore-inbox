Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRIZK2A>; Wed, 26 Sep 2001 06:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIZK1u>; Wed, 26 Sep 2001 06:27:50 -0400
Received: from web14702.mail.yahoo.com ([216.136.224.119]:44553 "HELO
	web14702.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271911AbRIZK1j>; Wed, 26 Sep 2001 06:27:39 -0400
Message-ID: <20010926102805.80450.qmail@web14702.mail.yahoo.com>
Date: Wed, 26 Sep 2001 03:28:05 -0700 (PDT)
From: Peter Moscatt <pmoscatt@yahoo.com>
Subject: Attempting to kill the idle task ??
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently trying to compile and install a new
kernel (2.4.10) into my Mandrake system.

I decided to use the 'make oldconfig' option in an
effort to keep the current settings.

I created the 'bzdisk' so I can test the system prior
to compiling a 'bzImage'

After making the modules then modules_install, I
conducted a reboot and ran off the boot floppy.

I got the following error:

"nic: Attempting to kill the idle task!
In idle task - not stncing
<1> Unable to handle kernel NULL pointer dereference
at virtual address 00000000"

Then I get a screen full of numbers and end up with:

"nic: Aiee, killing interrupt handler!
In interrupt handler - not syncing"


What have I done/not done to have this problem ?

Pete



__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger. http://im.yahoo.com
