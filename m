Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263178AbVGAA6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbVGAA6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbVGAA6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:58:08 -0400
Received: from [218.94.38.154] ([218.94.38.154]:44949 "EHLO xianan.com.cn")
	by vger.kernel.org with ESMTP id S263178AbVGAA6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:58:05 -0400
X-AuthUser: chengq@xianan.com.cn
Message-ID: <42C49511.3060307@gmail.com>
Date: Fri, 01 Jul 2005 08:57:53 +0800
From: Benbenshi <benbenshi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org
Subject: Re: route reload after interface restart
References: <dc849d8505063004136573e59e@mail.gmail.com>	 <200506301418.04419.vda@ilport.com.ua> <dc849d850506300711a92042@mail.gmail.com> <42C492A8.3020702@trash.net>
In-Reply-To: <42C492A8.3020702@trash.net>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

>chengq wrote:
>  
>
>>>>Routes relate to ethX were deleted from kernel after i shutdown ethX
>>>>(ifconfig ethX down),but after i start ethX (ifconfig ethX
>>>>XXX.XXX.XXX.XXX up ),  deleted  routes were not re-add to kernel .
>>>>        
>>>>
>
>If you specify a netmask for the device a route will be added.
>
>Regards
>Patrick
>
>
>  
>
sorry ,i cannot follow you.
you mean i have to specify the netmask when i startup the device ?
can you tell more details ?

regards,

Axin
