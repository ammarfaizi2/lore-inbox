Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbVLBGGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbVLBGGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 01:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbVLBGGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 01:06:54 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:20417 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751661AbVLBGGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 01:06:53 -0500
Message-ID: <438FE47A.7080100@ru.mvista.com>
Date: Fri, 02 Dec 2005 09:06:50 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051201182257.GB20516@kroah.com>
In-Reply-To: <20051201182257.GB20516@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>>- The character device interface was reworked
>>    
>>
>
>reworked how?
>  
>
It was originally designed for 2.6.10 and now it's 2.6-git-synchronized.

>  
>
>>- it's more adapted for use in real-time environments
>>    
>>
>
>I still do not see why you are stating this.  Why do you say this?
>  
>
Due to possible priority inversion problems in David's core.

>I think you should work with David more...
>  
>
P'haps you're right. I suggest re-enumerating all the differences 
between the cores and working them out.
However, if David's not going to accept any facts or speculations that 
contradict his being sure his core is the best a man could ever do, 
we're screwed. :(

Vitaly
