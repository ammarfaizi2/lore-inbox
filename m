Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWD0Vjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWD0Vjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWD0Vjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:39:35 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:26485 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751702AbWD0Vje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:39:34 -0400
Message-ID: <44513A0C.3020403@tmr.com>
Date: Thu, 27 Apr 2006 17:39:24 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler question 2.6.16.x
References: <200604251905.19004.nick@linicks.net> <20060425181530.GQ4102@suse.de> <200604251933.48363.nick@linicks.net>
In-Reply-To: <200604251933.48363.nick@linicks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> On Tuesday 25 April 2006 19:15, Jens Axboe wrote:
> 
>>> But I can build both in... so I guess then the kernel decides what is
>>> the best to use?  Or should it be so I am only allowed to select one
>>> or the other and allowing both is an oversight?
>> See the option no more than two lines down from that, default io
>> scheduler. Also see Documentation/block/switching-sched.txt and/or
>> Documentation/kernel-parameters.txt (elevator=) section.
> 
> Hi Jens,
> 
> I haven't got the switching-sched.txt, although I found a sched-design.txt... 
> but what I meant was if I select whatever default, do/can I still need to 
> select either/or scheduler?
> 
> i.e. why doesn't 'default selection option' only allow that scheduler to be 
> selected?

Not clear is you mean "allow that to the the only selection" which it 
does, or "only allow that selection" which makes no sense, you can boot 
using any compiled scheduler.

My configuration for beverage is set to "cask conditioned IPA" but I 
have most of the "Microbrewed" selections for IPA, PA, Stout and Porter 
compiled in. The "bland American and imported brews" section is 
disabled, with "water" enabled as a module.

The preference is what you use by default, but not an irrevocable choice.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
