Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTHLSaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHLSaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:30:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:33286 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271055AbTHLSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:30:07 -0400
Message-ID: <3F39358D.5040506@techsource.com>
Date: Tue, 12 Aug 2003 14:44:29 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, gaxt <gaxt@rogers.com>,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
References: <3F38FCBA.1000008@rogers.com> <3F22F75D.8090607@rogers.com> <200307292246.36808.kernel@kolivas.org> <3F38FCBA.1000008@rogers.com> <5.2.1.1.2.20030812193758.0197b9c0@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> 
> That sounds suspiciously similar to my scenario, but mine requires a 
> third element to trigger.
> 
> <scritch scritch scritch>
> 
> What about this?  In both your senario and mine, X is running low on 
> cash while doing work at the request of a client right?  Charge for it.  
> If X is lower on cash than the guy he's working for, pick the client's 
> pocket... take the remainder of your slice from his sleep_avg for your 
> trouble.  If you're not in_interrupt(), nothing's free.  Similar to 
> Robinhood, but you take from the rich, and keep it :)  He's probably 
> going straight to the bank after he wakes you anyway, so he likely won't 
> even miss it.  Instead of backboost of overflow, which can cause nasty 
> problems, you could try backtheft.


How is this different from back-boost?


