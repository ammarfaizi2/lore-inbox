Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTGUN1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270094AbTGUN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:27:34 -0400
Received: from sina187-156.sina.com.cn ([202.106.187.156]:9993 "HELO sina.com")
	by vger.kernel.org with SMTP id S270093AbTGUN1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:27:33 -0400
Message-ID: <3F1C613C.6070109@sina.com>
Date: Mon, 21 Jul 2003 21:55:08 +0000
From: snoopyzwe <snoopyzwe@sina.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20021130
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: how to calculate the system idle time
References: <3F1C570E.8080607@sina.com> <Pine.LNX.4.53.0307210935180.17719@chaos>
In-Reply-To: <Pine.LNX.4.53.0307210935180.17719@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for you advice
one foolish question
what "top" means?
could you tell me more about how to watch the system?
thank you very much
I am a newbie

>On Mon, 21 Jul 2003, snoopyzwe wrote:
>
>  
>
>>I want to implement a module, whose main task is to check the system
>>idle time(no keyboard and mouse input) and suspend the whole system(when
>>the idle time is long enough). But there comes the problem, how to
>>calculate the system idle time. How can I get the time user has no
>>operation.
>>thanks
>>snoopyzwe
>>
>>    
>>
>
>The the source-code of `top` and review it. Make a user-mode
>daemon to watch the system...
>
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>            Note 96.31% of all statistics are fiction.
>
>
>
>
>  
>



