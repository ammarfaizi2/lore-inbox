Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTH0QIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTH0QIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:08:02 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46255 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263549AbTH0QGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:06:34 -0400
Message-ID: <3F4CD420.4000603@namesys.com>
Date: Wed, 27 Aug 2003 19:54:08 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Yury Umanets <umka@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 snapshot for August 26th.
References: <20030826102233.GA14647@namesys.com>	 <20030827055204.GA18114@cse.unsw.EDU.AU>	 <1061964211.15513.41.camel@haron.namesys.com> <1061983191.678.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1061983191.678.1.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>On Wed, 2003-08-27 at 08:03, Yury Umanets wrote:
>  
>
>>> 
>>>Information: Reiser4 is going to be created on /dev/sda5.
>>>(Yes/No): Yes
>>>Creating reiser4 on /dev/sda5...
>>>mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f7661
>>>mkfs.reiser4(5676): unaligned access to 0x60000000000242fa, ip=0x20000000000f77a1
>>>mkfs.reiser4(5676): unaligned access to 0x6000000000024302, ip=0x20000000000f78e1
>>>mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f2671
>>>done
>>>Synchronizing /dev/sda5...done
>>>      
>>>
>>I will fix it soon.
>>    
>>
>
>Will Reiser4 be integrated into 2.6.0-test kernels anytime soon?
>This would reduce time between releases and would open up it to a wider
>audience for testing
>
>
>
>  
>
This is not a Namesys decision, I encourage you to ask Linus and Andrew 
about it though.  I would like to see it go in as an experimental marked 
filesystem....

-- 
Hans


