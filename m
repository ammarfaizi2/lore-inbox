Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSDMXwC>; Sat, 13 Apr 2002 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDMXwB>; Sat, 13 Apr 2002 19:52:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12304 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311403AbSDMXwA>; Sat, 13 Apr 2002 19:52:00 -0400
Message-ID: <3CB8B5F4.8040402@evision-ventures.com>
Date: Sun, 14 Apr 2002 00:49:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andre Hedrick <andre@linux-ide.org>, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <E16wRU9-0000hL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>The global "wheee I'm a poor and can't afford 32 bit IO" option will remain
>>>there of course.
>>>
>>>So we have no  issue here. OK?
>>
> 
> What if the user doesn't know the precise innards of their hardware. IDE
> more than anything else has to automagically do the right thing. Given the
> size of the PIO transfer loop and the way for some boards its weirdly 
> dependant on hardware magic and wonder is there any reason for not just 
> making the host controller provide the function or reference an ide library
> function for "sane" hardware ?

Alan - that's not the issue here.

