Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbUEKSjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUEKSjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUEKShl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:37:41 -0400
Received: from terra.inf.ufsc.br ([150.162.60.10]:44736 "EHLO
	terra.inf.ufsc.br") by vger.kernel.org with ESMTP id S263159AbUEKShY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:37:24 -0400
Message-ID: <40A11EA7.2010107@inf.ufsc.br>
Date: Tue, 11 May 2004 15:42:47 -0300
From: Thiago Robert <robert@inf.ufsc.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Write-combining
References: <40A0E808.2020602@inf.ufsc.br> <6uk6zjypg3.fsf@zork.zork.net>
In-Reply-To: <6uk6zjypg3.fsf@zork.zork.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone certain about this?

Thanks in advance.

_________________________
Thiago Robert


Sean Neakums wrote:

>Thiago Robert <robert@inf.ufsc.br> writes:
>
>  
>
>>Is the default behaviour of the Linux kernel to enable
>>write-combining? How can I be sure if it is enabled or not?
>>    
>>
>
>My /proc/mtrr lists the following region:
>
>reg03: base=0xf8000000 (3968MB), size=  64MB: write-combining, count=2
>
>which I am guessing is the PCI space, although I'm not certain.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

