Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265330AbTFRQaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTFRQaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:30:10 -0400
Received: from armitage.toyota.com ([63.87.74.3]:22466 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP id S265330AbTFRQaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:30:02 -0400
Message-ID: <3EF096CD.8060407@lexus.com>
Date: Wed, 18 Jun 2003 09:43:57 -0700
From: Joe <joe@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
 Windows!
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no> <E19SZ8v-0005Ie-00@relay-1.seagha.com>
In-Reply-To: <E19SZ8v-0005Ie-00@relay-1.seagha.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Vogel wrote:

>On 18 Jun 2003, you wrote in linux.kernel:
>
>  
>
>>rmoser wrote:
>>[...]
>>    
>>
>>>Ten minutes later I get the brains to run top.  It seems I have about
>>>50 MB in swap, and 54 MB free memory.  So I wait ten minutes more.
>>>
>>>No change.
>>>
>>>% swapoff -a; swapon -a
>>>
>>>Fixes all my problems.
>>>
>>>Now this long story shows something:  The kernel appears to be unable
>>>to intelligently pull swap back into RAM.  What gives?
>>>
>>>      
>>>
>>Because the problem _is_ unsolvable.  You want the kernel
>>to go "oh, lots of free memory showed up, lets pull
>>everything in from swap just in case someone might need it."
>>    
>>
>
>
>You might want to try Con Kolivas' patches on:
>   http://members.optusnet.com.au/ckolivas/kernel/
>  
>
Unfortunately he provided no information as to
what kernel and/or distro he is running - for all
we know he's running 2.4.9 - so the con man's
patches probably won't apply.

Joe

>  
>


