Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278732AbRJVLmJ>; Mon, 22 Oct 2001 07:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278733AbRJVLl7>; Mon, 22 Oct 2001 07:41:59 -0400
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:25864 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S278732AbRJVLlp>; Mon, 22 Oct 2001 07:41:45 -0400
Message-Id: <4.3.2.7.2.20011022073529.00d8dcf0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Oct 2001 07:42:17 -0400
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: Re: LPP (was: The new X-Kernel !)
In-Reply-To: <15va3i-0cRXvcC@fmrl00.sul.t-online.com>
In-Reply-To: <20011022022839.A8452@unthought.net>
 <20011021220346.D19390@vega.digitel2002.hu>
 <15vQtM-22TOdsC@fmrl02.sul.t-online.com>
 <20011022022839.A8452@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I correctly remember the days when I used NeXTSTEP, there were two boot 
modes.  In graphics mode, there was a status bar.  In verbose (text) mode, 
all the messages appeared.  As the boot started, there was a prompt in 
which you could specify single-user mode, verbose mode, etc.  With no 
specification, after a few seconds it would go ahead and boot.  Also, the 
mode (graphics vs text) could be set via the Preferences capability.

As a software developer, most of the time I didn't want/need the messages 
so I'd let it run in graphics mode.  Of course when the boot had a problem, 
I'd reboot and run it verbose (text) mode.

David

At 08:57 PM 10/21/01, you wrote:
>On Monday 22 October 2001 02:28, you wrote:
> > How would hiding that information make the system "easier to use" ?
>
>Because the majority of people (and especially those who haven't been reached
>by Linux yet) don't care for the messages. They are as interested in boot
>messages as you may be in reading debug information from your DVD player or
>car.
>
>Assuming you have a car with a display for the embedded computer, and you
>don't know anything about its software or hardware, you just want to drive.
>Would you prefer to see lots of cryptic messages when you turn the key, or
>just some simple picture with a progress bar showing you when the system is
>ready?
>IMHO the bar is all you need. Everything else just distracts you from the
>only important thing.
>
>Showing unimportant information is like turning on debug messages that you
>don't need.
>
>bye...
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

