Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUEQPGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUEQPGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUEQPGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:06:41 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:34830 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261576AbUEQPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:05:48 -0400
Message-ID: <40A8D4D9.2020703@hp.com>
Date: Mon, 17 May 2004 11:06:01 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517125705.GA23455@cathedrallabs.org>
In-Reply-To: <20040517125705.GA23455@cathedrallabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Sergio Rozanski Filho wrote:

>Hi Andrew,
>
>  
>
>>+hpet-driver.patch
>>
>> HPET clock driver (needs work)
>>    
>>
>this doesn't compiles if ACPI isn't present. patch attached.
>
>  
>
So you have HPET hardware which can be discovered without ACPI?  How is 
the HPET detected?  Are you just using the HPET addresses documented for 
Southbridge?

thanks,

Bob

