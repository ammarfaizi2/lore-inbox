Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSCCWnn>; Sun, 3 Mar 2002 17:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSCCWnd>; Sun, 3 Mar 2002 17:43:33 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:40937 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290184AbSCCWnV>;
	Sun, 3 Mar 2002 17:43:21 -0500
Message-ID: <3C82A702.1030803@candelatech.com>
Date: Sun, 03 Mar 2002 15:43:14 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>I'm running the program at nice -18.
>>So, what kind of things can I do to decrease the latency?
>>
> 
> Hack up the ksoftirq stuff to only fall back to ksoftirqd after about
> 500 iterations instead of one is one little detail to deal with


Can someone expound slightly on this?


> 
> 
>>Would the low-latency patch help me?
>>
> 
> Yes


Excellent, I'm compiling that now....

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


