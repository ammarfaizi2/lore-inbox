Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJZVWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJZVWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUJZVWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:22:05 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21653 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261474AbUJZVVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:21:49 -0400
Message-ID: <417EC072.8010904@tmr.com>
Date: Tue, 26 Oct 2004 17:24:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Gryniewicz <dang@fprintf.net>
CC: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <417D73C8.5040204@tmr.com><1098485798.6028.83.camel@gaston> <1098754050.19465.3.camel@athena.fprintf.net>
In-Reply-To: <1098754050.19465.3.camel@athena.fprintf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Gryniewicz wrote:
> On Mon, 2004-10-25 at 17:44 -0400, Bill Davidsen wrote:
> 
>>David Woodhouse wrote:
>>
>>
>>>Damn right. If 2.6.10 doesn't boot on the G5 with i8042 and 8250 drivers
>>>built in, and doesn't sleep (well, more to the point doesn't resume) on
>>>my shinybook, I shall sulk :)
>>
>>Suspend is Shakespearean, "to sleep, perchance to dream." I don't know 
>>why people are still trying the fix suspend, it works perfectly on all 
>>my machines, I would like to see some work on wake-the-@-up at this point.
>>
>>The sad part is that using apm and 2.4, all my laptops seem happy to 
>>sleep and wake when asked. One of the reasons I'm running 2.4 on the old 
>>ones, the new ones boot fast enought that I don't care.
>>
> 
> 
> Well, for me, 2.6.9 *broke* wake up.  Suspend still works fine, but I'm
> back to 2.6.9-rc4 to get working wake up.

I think you missed my point... I said suspend works now work on wakeup. 
Same issue you have.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
