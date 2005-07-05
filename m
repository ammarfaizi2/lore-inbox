Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVGELih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVGELih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGELie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:38:34 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:43369 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261830AbVGELZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 07:25:42 -0400
Message-ID: <42CA6E2F.7000408@bigpond.net.au>
Date: Tue, 05 Jul 2005 21:25:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.1 for 2.6.11 and 2.6.12
References: <42B65525.1060308@bigpond.net.au> <42B65FAC.4090400@bigpond.net.au> <42CA3AEA.3020204@bigpond.net.au> <200507051953.49132.kernel@kolivas.org>
In-Reply-To: <200507051953.49132.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 5 Jul 2005 11:25:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 5 Jul 2005 17:46, Peter Williams wrote:
> 
>>Peter Williams wrote:
>>
>>>Con Kolivas wrote:
>>>
>>>>On Mon, 20 Jun 2005 15:33, Peter Williams wrote:
>>>>
>>>>>PlugSched-5.2.1 is available for 2.6.11 and 2.6.12 kernels.  This
>>>>>version applies Con Kolivas's latest modifications to his "nice" aware
>>>>>SMP load balancing patches.
>>>>
>>>>Thanks Peter.
>>>>Any word from your own testing/testers on how well smp nice balancing
>>>>is working for them now?
>>>
>>>No, they got side tracked onto something else but should start working
>>>on it again soon.  I'll give them a prod :-)
>>
>>Con,
>>	We've done some more testing with this with results that are still
>>disappointing. 
> 
> 
> Is this with the migration thread accounted patch as well?

Yes.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
