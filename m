Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVLPDvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVLPDvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLPDvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:51:40 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:28449 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932113AbVLPDvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:51:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=AYPkycm2rRdg+iOQnimAGTpYxLYDueyC83HzKlM0eUbi3NPhx+62PH57K2KUqWRG35CjBKWsB+UMIMwH50GWLQC9vXipKKj19Sb+lGeiw7PXAsCQH/jHxMpqnqtK+r1bw6S5u9w50zV3TNqA2lbRFDaql6i0zI9FSpX5xxEAAhw=
Message-ID: <43A239B4.8010309@gmail.com>
Date: Thu, 15 Dec 2005 22:51:16 -0500
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ismail Donmez <ismail@uludag.org.tr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051211180536.GM23349@stusta.de> <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr> <200512160112.30179.ismail@uludag.org.tr>
In-Reply-To: <200512160112.30179.ismail@uludag.org.tr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
From: Puneet Vyas <puneetvyas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez wrote:

>Cuma 16 Aralık 2005 00:57 tarihinde şunları yazmıştınız:
>  
>
>>>It seems most problems with 4k stacks are already resolved at least
>>>in -mm.
>>>
>>>I'd like to see this patch to always use 4k stacks in -mm now for
>>>finding any remaining problems before submitting this patch for Linus'
>>>tree.
>>>      
>>>
>>By chance, I read that windows modules used in ndiswrapper
>>may require >4k-stacks. Will this become a problem?
>>    
>>
>
>If 8k stacks get removed, yes. So if you have a chance to choose don't buy a 
>wifi card which doesn't have a native linux driver.
>
>  
>
If the learned folks here think that "ndiswrapper" is some user space 
program that people can live without than at least
3 people in my house are doomed. We like to use linux but do not have 
luxury that Ismail enjoys. At least windows
does not make such decisions on my behalf. Sigh.

~Puneet
