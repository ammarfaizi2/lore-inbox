Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUHCHnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUHCHnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUHCHnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:43:22 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:54660 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265269AbUHCHnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:43:17 -0400
Message-ID: <410F4211.5050601@yahoo.com.au>
Date: Tue, 03 Aug 2004 17:43:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org>
In-Reply-To: <cone.1091518501.973503.9648.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Nick Piggin writes:
> 
>> Con Kolivas wrote:
>>
>>> Andrew Morton wrote:
>>
>>
>>> Anyone with feedback on this please cc me. This was developed 
>>> separately from the -mm series which has heaps of other scheduler 
>>> patches which were not trivial to merge with so there may be teething 
>>> problems. Good reports dont hurt either ;)
>>>
>>
>> I can't get onto the OSDL site now, but I seem to remember staircase
>> having some performance problems on a few things. Hackbench and reaim
>> from memory... are these fixed? was I dreaming?
> 
> 
> Definitely dreaming I'm afraid :D
> 
> The performance on both reaim and hackbench has always equalled or 
> exceeded mainline so thanks for bringing it up.
> 

Oh OK. Weird :). I'll run a few tests when OSDL comes back up anyway.
