Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWFPNpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWFPNpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFPNpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 09:45:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751404AbWFPNpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 09:45:54 -0400
Message-ID: <4492B611.50000@redhat.com>
Date: Fri, 16 Jun 2006 09:45:53 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janne Karhunen <Janne.Karhunen@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 client reordering RENAMEs
References: <200606151638.15792.Janne.Karhunen@gmail.com> <200606151754.33384.Janne.Karhunen@gmail.com> <44918545.2090002@redhat.com> <200606160925.51332.Janne.Karhunen@gmail.com>
In-Reply-To: <200606160925.51332.Janne.Karhunen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne Karhunen wrote:

>On Thursday 15 June 2006 19:05, Peter Staubach wrote:
>
>  
>
>>>Possibly .. if someone first acks that this indeed would be
>>>considered as bug and not as a feature :/
>>>      
>>>
>>Yes, I believe that this would be considered to be a bug...
>>    
>>
>
>Looks that this is a vendor kernel issue, couldn't get it to
>barf on mainline. Without any more knowledge of the extent 
>of the problem testcase attached. Given that you suffer from
>the problem you should occasionally see files vanishing.
>

Although this is a little timing dependent, it mostly should work.  How
long does it need to run before failures will be seen?  I have been running
it for about half an hour and it seems to be operating as I expected.


I would suggest reporting this issue to your vendor and see what they
have to say.

    Thanx...

       ps
