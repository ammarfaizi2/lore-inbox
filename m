Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136437AbRAJVFh>; Wed, 10 Jan 2001 16:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136463AbRAJVF3>; Wed, 10 Jan 2001 16:05:29 -0500
Received: from ns1.megapath.net ([216.200.176.4]:17682 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S136437AbRAJVFJ>;
	Wed, 10 Jan 2001 16:05:09 -0500
Message-ID: <3A5CCE41.9050109@megapathdsl.net>
Date: Wed, 10 Jan 2001 13:04:01 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Kaiser <rob@sysgo.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <Pine.LNX.4.21.0101101618120.19662-100000@dagobert.svc.sysgo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kaiser wrote:

<snip>

>> I have periodically built kernels that crashed
>> immediately at the point you mention.  Usually this
>> was due to me choose configuration options that
>> were incompatible with my machine's hardware.
> 
> 
> You mean they crashed at the exact same statement ?
> That would be an interesting hint, can you confirm it ?

I sent the "possible config problem" list mostly
as a warning about what can cause kernels to lock up
early in the boot cycle.  Some of the problems I ]
mentioned will cause a lock up immediately after
the "Uncompressing kernel... OK Booting Linux" message.

I doubt that these problems are causing your problem
and so I really doubt that these crashes are occuring
in the same function that yours is.

Mostly, I thought you might want to double-check your
configuration options and make sure that you are using
none of these broken configuration combinations.

Good luck!  I wish I could be of more help.

	Miles


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
