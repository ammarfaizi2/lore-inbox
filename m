Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293429AbSCFKSI>; Wed, 6 Mar 2002 05:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCFKR7>; Wed, 6 Mar 2002 05:17:59 -0500
Received: from [195.63.194.11] ([195.63.194.11]:19462 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293429AbSCFKRq>; Wed, 6 Mar 2002 05:17:46 -0500
Message-ID: <3C85EC39.7030102@evision-ventures.com>
Date: Wed, 06 Mar 2002 11:15:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Anton Altaparmakov <aia21@cam.ac.uk>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iPHQ-0004sL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>At 11:48 05/03/02, Martin Dalecki wrote:
>>
>>>5. No body is using it as of now and therefore nobody should miss it.
>>>
>>That is a very bold statement which is incorrect. I remember reading at 
>>least one post to lkml from a company who is using the Taskfile ioctls and 
>>
> 
> I know several people using them, and for some ioctl operations they are
> required. In fact without taskfile ioctl stuff I can't make my laptop resume
> correctly for example. (it needs proper drive please wake up sequences to
> go the ibm microdrive)

I would rather love to see a systrace of it in action to see which
API this is actually really using. ;-).

