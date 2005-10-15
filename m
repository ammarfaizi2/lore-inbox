Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVJOGvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVJOGvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVJOGvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:51:08 -0400
Received: from 10.ctyme.com ([69.50.231.10]:38786 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1751098AbVJOGvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:51:07 -0400
Message-ID: <4350A6D5.7010304@perkel.com>
Date: Fri, 14 Oct 2005 23:51:01 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe> <2cd57c900510142347y41ca98b1gf7172898d2bdc97a@mail.gmail.com>
In-Reply-To: <2cd57c900510142347y41ca98b1gf7172898d2bdc97a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
X-Mail-from: marc@perkel.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Coywolf Qi Hunt wrote:

>On 10/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
>  
>
>>On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
>>    
>>
>>>Is there any way to force an immediate reboot as if to push the reset
>>>button in software? Got a remote server that i need to reboot and
>>>shutdown isn't working.
>>>      
>>>
>>If it has Oopsed, and the "reboot" command does not work, then all bets
>>are off - kernel memory has probably been corrupted.
>>
>>Get one of those powerstrips that you can telnet into and power cycle
>>things remotely.
>>
>>    
>>
>
>use reboot on panic.
>  
>

But it didn't panic. It was still running - filtering spam. But reboot 
wouldn't work and I couldn't kill anything that was running. So it never 
paniced.
