Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbTLRXyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265409AbTLRXyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:54:45 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:43406 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265408AbTLRXyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:54:43 -0500
Message-ID: <3FE23E3F.2000801@cyberone.com.au>
Date: Fri, 19 Dec 2003 10:54:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: karim@opersys.com
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainers
References: <3FE234E4.8020500@opersys.com> <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com> <3FE23966.7060001@opersys.com> <Pine.LNX.4.58.0312181836360.19491@montezuma.fsmlabs.com> <3FE23CD1.4080802@opersys.com>
In-Reply-To: <3FE23CD1.4080802@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Karim Yaghmour wrote:

>
> Zwane Mwaikambo wrote:
>
>> But you're forgetting what the MAINTAINERS file is for. I can't but help
>> thinking that this is linked with the email you sent earlier, but that's
>> just me. Frankly i reckon this particular case could be settled by
>> removing both from MAINTAINERS as neither has code in the 2.6 linux
>> kernel. Anybody looking for realtime Linux kernel capabilities can 
>> just do
>> a Google.
>
>
> Yes, yes, and guess what shows up top on that google results list :)
>
> Seriously though, the final decision isn't mine. I've submitted the
> patch and I personally think that it's more than justfied. I'll
> leave it to the wisdom of the people in charge to make the appropriate
> decision.


I agree with Zwane. People have enough trouble using MAINTAINERS
as it is. Using it to pat each others backs makes it less useful.

As Zwane said, neither have code in the kernel, so I don't see how
you think it is justified...?


