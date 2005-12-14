Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVLNT3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVLNT3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLNT3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:29:46 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:39024 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932131AbVLNT3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:29:45 -0500
Message-ID: <43A07294.3030805@ru.mvista.com>
Date: Wed, 14 Dec 2005 22:29:24 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141050.55294.david-b@pacbell.net>
In-Reply-To: <200512141050.55294.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Wednesday 14 December 2005 9:53 am, Vitaly Wool wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>What is the speed of your SPI bus?
>>>
>>>And what are your preformance requirements?
>>> 
>>>
>>>      
>>>
>>The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
>>at true 10 Mbit/sec.
>>    
>>
>
>Some SPI flash chips are rated at 60 MHz ... there's no "official"
>standard placing such limits on SPI.
>  
>
David, can you please stop treating me as an idiot? Of course I meant 
the specific SPI bus we're working with which is quite evident from the 
context.
Thanks.

Vitaly
