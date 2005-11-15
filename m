Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVKOROI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVKOROI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVKOROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:14:08 -0500
Received: from mail.timesys.com ([65.117.135.102]:65424 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964924AbVKOROG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:14:06 -0500
Message-ID: <437A14FB.8050206@timesys.com>
Date: Tue, 15 Nov 2005 12:03:55 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Luca Falavigna <dktrkranz@gmail.com>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
References: <4378B48E.6010006@gmail.com> <20051115153257.GA9727@elte.hu>
In-Reply-To: <20051115153257.GA9727@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 17:06:10.0609 (UTC) FILETIME=[E0705A10:01C5EA06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Luca Falavigna <dktrkranz@gmail.com> wrote:
>>I found this softlockup bug involving arts daemon using a
>>linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
>>Lockups" compiled in).
>>This bug does not happen everytime: I was able to reproduce it only
>>three times in a week. [...]
> 
> 
> does this happen with -rt13 too? I have fixed a softlockup 
> false-positive in it.

Just curious what the cause of the false positive was?

-john

-- 
john.cooper@timesys.com
