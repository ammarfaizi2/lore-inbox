Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVAJRsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVAJRsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVAJRrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:47:19 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:60897 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262372AbVAJRZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:25:56 -0500
Message-ID: <41E2BAAB.3070805@tiscali.de>
Date: Mon, 10 Jan 2005 18:26:03 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
CC: Adam Anthony <aanthony@sbs.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520
References: <200501101947.33917.adobriyan@mail.ru>
In-Reply-To: <200501101947.33917.adobriyan@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>On Mon, 10 Jan 2005 07:46:52 -0700, Adam Anthony wrote:
>
>  
>
>>With the permission of my employer, SBS Technologies, Inc., I have
>>released a patch for 2.4 kernels that supports the 520 Series of WAN
>>adapters.
>>    
>>
>
>My editor shows ^M at the end of every line of new Documentation/Configure.help,
>MAINTAINERS (add ~63400 bogus lines!). Please, look at the patch _after_
>generating it.
>
>  
>
>>+obj-$(CONFIG_LANMEDIA)		+=		syncppp.o^M
>>    
>>
>
>  
>
>>+subdir-$(CONFIG_LANMEDIA) += lmc^M
>>    
>>
>
>Also random ^M's.
> 
>--- linux-2.4.28-virgin/drivers/net/wan/sbs520/lnxosl.c
>+++ /usr/src/linux-2.4.28/drivers/net/wan/sbs520/lnxosl.c
>
>  
>
>>+// Programming Language:	C^M
>>+// Target Processor:		Any^M
>>+// Target Operating System: Linux^M
>>    
>>
>
>Well, this is pretty obvious to everyone here. :-)
>
>  
>
>>+// This software may be used and distributed according to the terms^M
>>+// of the GNU General Public License, incorporated herein by reference.^M
>>    
>>
>
>Stupid question: do you mean GPL version 2 or something else?
>
>	Alexey
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
That's ugly, that are Microsoft line endings.

Matthias-Christian Ott
