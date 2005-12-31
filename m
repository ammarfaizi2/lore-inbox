Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVLaRZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVLaRZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLaRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:25:59 -0500
Received: from [202.67.154.148] ([202.67.154.148]:47015 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S965030AbVLaRZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:25:59 -0500
Message-ID: <43B6BF29.1000800@ns666.com>
Date: Sat, 31 Dec 2005 18:26:01 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com> <20051231170231.GF3214@m.safari.iki.fi>
In-Reply-To: <20051231170231.GF3214@m.safari.iki.fi>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Sat, Dec 31, 2005 at 05:48:41PM +0100, Mark v Wolher wrote:
> 
>>Sami Farin wrote:
> 
> ...
> 
>>>Can you try how many seconds it takes to get Oops/crash when you start
>>>pressing 'v' in xawtv (video capture on/off).
>>>For me, not very many.
>>>
>>>This happens with every 2.6 kernel.  And my hardware is OK.
> 
> ...
> 
>>Hi Sami,
>>
>>That caused also a crash, i kept pressing the v key and within 15
>>seconds it crashed, then i saw the crash-info appear in the log and when
>>i clicked on mozilla then it crashed too but without crahs info and
>>system froze totally.
> 
> 
> Now if someone could figure out how to find the bug in bttv.
> My opinion/guess is that's where the bug is, not in buggy PCI hardware,
> as somebody said several months ago.
> 

I agree, i filled a report also on bugzilla. Also i have to mention that
when using xp pro no crashes/freezes occur, not even under heavy load
and tv on.

