Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUH1NcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUH1NcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUH1NcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:32:14 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6364 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265930AbUH1NcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:32:10 -0400
Message-ID: <41308A3E.5050407@namesys.com>
Date: Sat, 28 Aug 2004 16:35:58 +0300
From: Yury Umanets <umka@namesys.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
CC: Rodrigo FGV <rodrigof@bifgv.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Reiser 4
References: <006601c48bad$00c4b130$0700a8c0@ti10> <200408262011.29436.lkml@felipe-alfaro.com>
In-Reply-To: <200408262011.29436.lkml@felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>On Thursday 26 August 2004 22:40, Rodrigo FGV wrote:
>  
>
>>how i convert reiser3.6 to reiser4. this update is safe???
>>    
>>
>
>Backup / Format / Restore is the only way of migrating to Reiser4 (no magical 
>tool to convert from reiser3-to-reiser4 is available ATM).
>  
>
Hello!

There is nice tool called convertfs. Google it. If I recall correctly, 
it allows to perform inplace conversion of any FS to any :)

>  
>
>>the reiser4 have any critical bug?? anyone recommend this update???
>>    
>>
>
>It depends... I wouldn't recommend Reiser4 for production systems. AFAIK, 
>there are still some pending minor bugs, but it's very unlikely that it will 
>eat your data.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
umka

