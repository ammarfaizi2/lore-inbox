Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVERVng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVERVng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVERVng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:43:36 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25780 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262218AbVERVn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:43:28 -0400
Message-ID: <428BB602.2040909@tmr.com>
Date: Wed, 18 May 2005 17:39:14 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: What is needed to boot 2.6 on opteron dual core
References: <213219CA6232F94E989A9A5354135D2F0936FE@frqexc04.emea.cpqcorp.net> <m1br7a804l.fsf@muc.de>
In-Reply-To: <m1br7a804l.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com> writes:
> 
> 
>>Hello lkml,
>>
>>I am trying to boot a dual core Opteron box with linux 2.6 and it is
>>crashing very early (swapper process dies, backtrace shows SMP_boot....
>>Stuff) and I was wondering what patches are needed to boot a 2.6 kernel
>>on a dual core machine.
> 
> 
> It should work with most kernels. Just the level of tuning
> during runtime varies (with more tuning the newer the kernel) 
> Certainly does for me at least on the AMD reference motherboards/BIOS.

Could you clarify that? I have to install one when it comes in to the 
owner, and I'm not sure how you would do "runtime tuning" if it doesn't 
boot. Did you mean boot parameters, BIOS diddling, or ???

I didn't order the unit, but I believe it's an IBM rack mounted 2U case, 
whatever that might be.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

