Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVKOHN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVKOHN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVKOHN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:13:26 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:29312 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932320AbVKOHN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:13:26 -0500
Message-ID: <4379846E.2070006@wolfmountaingroup.com>
Date: Mon, 14 Nov 2005 23:47:10 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
Cc: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58MJb-2Sn-37@gated-at.bofh.it>	<58NvO-46M-23@gated-at.bofh.it>	<58Rpx-1m6-11@gated-at.bofh.it>	<58UGF-6qR-27@gated-at.bofh.it>	<58UQf-6Da-3@gated-at.bofh.it>	<437933B6.1000503@shaw.ca>	<1132020468.27215.25.camel@mindpipe>	<20051115032819.GA5620@redhat.com>	<43795575.9010904@wolfmountaingroup.com>	<20051115050658.GA13660@redhat.com>	<43797E05.5090107@wolfmountaingroup.com> <17273.34218.334118.264701@cse.unsw.edu.au>
In-Reply-To: <17273.34218.334118.264701@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Monday November 14, jmerkey@wolfmountaingroup.com wrote:
>  
>
>>Dave Jones wrote:
>>
>>    
>>
>>>On Mon, Nov 14, 2005 at 08:26:45PM -0700, Jeff V. Merkey wrote:
>>>
>>>      
>>>
>>>>NetWare used 16K stacks in kernel by default.
>>>>        
>>>>
>>>unsubscribe netware-kernel
>>> 
>>>
>>>      
>>>
>>Making the point that in 1990, folks had grown beyond 4K stacks in 
>>kernels, along with MS DOS 640K Limitations.
>>    
>>
>
>But I seem to remember learning in CS101 (or whatever we called it),
>that the stack grows down and the heap grows up.
>So if 'folks had grown beyond 4K stacks', I guess they must be at 2K
>stacks ?->
>
>NeilBrown
>  
>

Great point, and you are correct that MS DOS had bigger stacks than 4K. 
Onward through the fog ....

Jeff
