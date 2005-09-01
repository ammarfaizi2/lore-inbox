Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVIANJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVIANJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVIANJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:09:27 -0400
Received: from ctb-mesg9.saix.net ([196.25.240.89]:65155 "EHLO
	ctb-mesg9.saix.net") by vger.kernel.org with ESMTP id S965099AbVIANJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:09:27 -0400
Message-ID: <4316FD08.1070505@geograph.co.za>
Date: Thu, 01 Sep 2005 15:07:20 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
References: <4316E5D9.8050107@geograph.co.za> <20050901122253.GA11787@midnight.suse.cz>
In-Reply-To: <20050901122253.GA11787@midnight.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Thu, Sep 01, 2005 at 01:28:25PM +0200, Zoltan Szecsei wrote:
>
>  
>
>>Hi All,
>>The archives & FAQs on this subject stop at December 2003. Google not 
>>much help either (prob. due to my keyword choices)
>>
>>I gather the only way to do this is via the ruby patch.
>>
>>(When) Will there ever be native kernel (and maybe XFree) support for 
>>multiple independent keyboards?
>>    
>>
>
>The kernel console is unlikely to ever going to have that - noone is
>interested in changing the console subsystem.
>  
>
Ah, rats! :-(

>The current state of input device support in the kernel, however, allows
>any userspace program to access them independently, including keyboards.
>
>That means multi-user X and possibly a userspace console implementation
>(Jon Smirl is planning one) has no barriers in the kernel input device
>  
>
Do you have an email address so that I can keep in touch with him?

>implementation keeping it from proceeding.
>
>The problems with multiple VGA cards, etc, are much harder to solve,
>though.
>  
>
That's a surprise - barring the keyboard issue, I thought I was close to 
getting it working on my SuSE 9.3 using 2 mice, onboard 915G graphics 
and an old TSENG Labs ET6000.
Maybe I had further to go than I realised :-(

>  
>
>>The ruby patch seems to also only have discussions older than 18 months.
>>
>>Has there really been no progress in the last 18 months?
>>
>>I would prefer to see "official and permanent" support for this as then 
>>when HW & drivers & kernels develop in the future, this capability will 
>>always be (immediately) available - and not have to wait for patches.
>>    
>>
>
>Many people would like that. But not many enough to make it happen, at
>least not until now.
>  
>
Ah cool - there's hope - any pointers on how I can get a counter or 
lobby group going?  :-)

Thanks for taking time to reply.

Cheers,
Z


-- 

==================================
Geograph (Pty) Ltd
P.O. Box 31255
Tokai
7966
Tel:    +27-21-7018492
Fax:	+27-86-6115323
Mobile: +27-83-6004028
==================================


