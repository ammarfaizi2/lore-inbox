Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUBQNDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUBQNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:03:38 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:37553 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S266163AbUBQNDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:03:36 -0500
Message-ID: <4032112E.8050801@stesmi.com>
Date: Tue, 17 Feb 2004 14:03:42 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Nelson <pnelson@andrew.cmu.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PSX support in input/joystick/gamecon.c
References: <20040215222107.720832C2CC@lists.samba.org> <4031AB8D.1040209@andrew.cmu.edu>
In-Reply-To: <4031AB8D.1040209@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Nelson wrote:

> Rusty Russell wrote:
> 
>> In message <4023D7B9.9010201@andrew.cmu.edu> you write:
>>  
>>
>>> Hi, this is my first kernel hack but it's fairly straight froward.  I 
>>> did a partial-rewrite of the PSX support in gamecon.c to make it far 
>>> more usable.  What this patch changes:
>>>   
>>
>>
>> While you're there, want to change the code over to the new
>> module_param?
>>  
>>
> Sure, here's an update patch with the new module_param code.  I'll go 
> through and update the rest of the joystick modules if you want, but I 
> can't test them or guarantee they'll work (I have tested these changes 
> though).

Sorry to barge into the middle of the discussion here but why call
it PSX?

PSX was the workname of the original PlayStation and was then dropped.
The PlayStation was simply called "PS" and not PSX.

PSX stood for PlayStation eXperimental if I'm not incorrect.

PSX however is a new product from Sony that's a PS2 with some extra crap
thrown in.

Or am I misunderstanding and this driver is in fact for the PSX (the
new one) ?

// Stefan

