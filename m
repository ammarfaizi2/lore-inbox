Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313126AbSDOJ1e>; Mon, 15 Apr 2002 05:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSDOJ1c>; Mon, 15 Apr 2002 05:27:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17162 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313126AbSDOJ1c>; Mon, 15 Apr 2002 05:27:32 -0400
Message-ID: <3CBA8E70.5010605@evision-ventures.com>
Date: Mon, 15 Apr 2002 10:25:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: admin@nextframe.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup:
 idebus=66 -- BAD OPTION"
In-Reply-To: <20020415112332.A181@sexything>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:
> Hey Martin (and the rest of you)

> Now, I do not know the reasons for changing the code that handles "idebus=" stuff in ide.c (except from the fact

Should be an off by one error there.

> that it now looks cleaner :) - just thought I should let you know. I do not have the time right now to hunt down
> the bug(?) and cook up a patch, but if you want me to, I`ll do it later today. 

I would love if you could have a look at it...

> One more thing, Martin - I compiled a 2.5.8 with TCQ enabled (yep, I`m aware of the fact that this one is _really_ alpha :), 
> and tested it for, oh ... 10 minutes ... the system gave me all sorts of funny responses - segfaults, 
> "inconsistency in ld.so" and so on ... would you like me to collect 'funnies' and send them to you ? If so, just 
> give me a hint.

Thats mostly Jens stuff...

