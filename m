Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbREZLSV>; Sat, 26 May 2001 07:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262647AbREZLSM>; Sat, 26 May 2001 07:18:12 -0400
Received: from [209.10.41.242] ([209.10.41.242]:46565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262639AbREZLSC>;
	Sat, 26 May 2001 07:18:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 26 May 2001 04:09:13 -0700
Message-Id: <200105261109.EAA08552@baldur.yggdrasil.com>
To: jas88@cam.ac.uk
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Cc: aaronl@vitelus.com, acahalan@cs.uml.edu, dledford@redhat.com,
        linux-kernel@vger.kernel.org, lm@bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
>On Fri, 25 May 2001, Adam J. Richter wrote:
>> Larry McVoy wrote:
>> >On Fri, May 25, 2001 at 07:34:57PM -0700, Adam J. Richter wrote:

>> >It's also about the concept of boundaries - if you think that that
>> >concept is not a legal one then why aren't all programs which are run
>> >on top of a GPLed kernel then GPLed?
>>
>> 	Apparently Linus felt that that was a sufficiently
>> plausible gray area that he addressed it explicitly in
>> /usr/src/linux/COPYING:
>>
>> |   NOTE! This copyright does *not* cover user programs that use kernel
>> | services by normal system calls - this is merely considered normal use
>> | of the kernel, and does *not* fall under the heading of "derived work".
>> | Also note that the GPL below is copyrighted by the Free Software
>> | Foundation, but the instance of code that it refers to (the Linux
>> | kernel) is copyrighted by me and others who actually wrote it.

>Note the "derived work"; there is no way on this earth (or any other) that
>you could regard the device's firmware as being a "derived work" of the
>driver! AFAICS, the firmware is just a file served up to the device as
>needed - no more a derivative work from the kernel than my homepage is a
>derivative work of Apache.

	Nobody is arguing that it is illegal to copy the keyspan
firmware by itself.  What I think is clearly illegal is copying the
whole keyspan .o file, not because it infringes the firmware copyrights,
but because it infringes the GPL'ed material's copyrights.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
