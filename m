Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUH0IIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUH0IIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUH0IIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:08:37 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61395 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267702AbUH0IIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:08:11 -0400
Message-ID: <412EEBE9.3000507@namesys.com>
Date: Fri, 27 Aug 2004 01:08:09 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: linux-kernel@vger.kernel.org, Rodrigo FGV <rodrigof@bifgv.com.br>
Subject: Re: Reiser 4
References: <006601c48bad$00c4b130$0700a8c0@ti10> <200408261408.46998.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200408261408.46998.norberto+linux-kernel@bensa.ath.cx>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:

>Rodrigo FGV wrote:
>  
>
>>how i convert reiser3.6 to reiser4. 
>>    
>>
>
>Backup. Reformat. Restore.
>
>  
>
>>this update is safe??? 
>>    
>>
>
>Dunno. Many people is using it, so I guess it is.
>
>  
>
>>the reiser4 have any critical bug?? 
>>    
>>
>
>Doesn't like 4KSTACKS :(
>
>  
>
>>anyone recommend this update??? 
>>    
>>
>
>Hans does ;)
>And I would if it compiled with 4KSTACKS.
>  
>
zam is working on 4k stacks support.  Not sure why people care about it 
so much, but sometimes we do things to make users happy.....

>Best Regards,
>Norberto
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

