Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbULPP6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbULPP6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbULPP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:57:39 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11678 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261541AbULPPzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:55:15 -0500
Message-ID: <41C1B018.2090903@tmr.com>
Date: Thu, 16 Dec 2004 10:56:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Chandler <alan@chandlerfamily.org.uk>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem revisited - more brainpower needed
References: <200412121334.55460.alan@chandlerfamily.org.uk><200412121334.55460.alan@chandlerfamily.org.uk> <200412140020.18114.alan@chandlerfamily.org.uk>
In-Reply-To: <200412140020.18114.alan@chandlerfamily.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Chandler wrote:
> On Sunday 12 December 2004 13:34, Alan Chandler wrote:
> 
>>On Sunday 12 December 2004 11:39, Alan Cox wrote:
>>
>>>Thanks ok so it moves with the drive. I'm beginning to wonder if it is
>>>just a dud drive.
>>
>>I do too and am almost ready to throw in the towel (and I seem to be almost
>>unique in experiencing these problems) - except
> 
> 
> Towel now thrown.
> 
> ...
> 
> 
>>and
>>linux 2.4 (using the ide-scsi module) the drive works perfectly.
> 
> 
> Drive is obviously degrading, I tried it "one more time" today with 2.4, and 
> it only just managed to work.  It managed to finish the task, but there were 
> several resets and error messages very similar to the ones in 2.6.

Is it? Or did the firmware "upgrade" make it worse? Can you reflash back 
to the original firmware and see if 2.4 works correctly?

> My apologies to others time that I might have wasted, although it personally 
> was a good learning experience on how the kernel works.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
