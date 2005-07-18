Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVGROsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVGROsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGROpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:45:17 -0400
Received: from mail.tmr.com ([64.65.253.246]:18111 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261781AbVGROnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:43:55 -0400
Message-ID: <42DBC1F2.2040604@tmr.com>
Date: Mon, 18 Jul 2005 10:51:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel@kolivas.org
CC: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
References: <200507122110.43967.kernel@kolivas.org> <200507122202.39988.kernel@kolivas.org> <42D55562.3060908@tmr.com> <200507141021.55020.kernel@kolivas.org> <42D7B100.2010308@tmr.com> <1121424116.42d792f47c70b@vds.kolivas.org>
In-Reply-To: <1121424116.42d792f47c70b@vds.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@kolivas.org wrote:

>Quoting Bill Davidsen <davidsen@tmr.com>:
>
>  
>

>>>>Disk tests should be at a fixed rate, not all you can do. That's NOT
>>>>realistic.
>>>>   
>>>>
>>>>        
>>>>
>>>Not true; what you suggest is another thing to check entirely, and that
>>>      
>>>
>>would 
>>    
>>
>>>be a valid benchmark too. What I'm interested in is what happens if you read
>>>      
>>>
>>>or write a DVD ISO image for example to your hard disk and what this does to
>>>      
>>>
>>>interactivity. This sort of reading or writing is not throttled in real
>>>      
>>>
>>life.
>>    
>>
>>Of course it is. At least the read. It's limited to the speed needed to 
>>either play (watch) the image or to burn it.
>>    
>>
>
>Ok we'll call it hair splitting. We do both. You read the file and I copy it.
>Both happen in real life, and I plan to emulate both.
>

And that sounds exactly correct.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

