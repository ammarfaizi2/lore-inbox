Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbTH0C1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 22:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTH0C1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 22:27:04 -0400
Received: from dyn-ctb-203-221-73-100.webone.com.au ([203.221.73.100]:41478
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263032AbTH0C1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 22:27:01 -0400
Message-ID: <3F4C16E7.9010601@cyberone.com.au>
Date: Wed, 27 Aug 2003 12:26:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Riesen <fork0@users.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O18.1int
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM> <yw1xad9yca8j.fsf@users.sourceforge.net> <3F49E482.7030902@cyberone.com.au> <20030825102933.GA14552@Synopsys.COM> <20030826222032.GA1055@steel.home>
In-Reply-To: <20030826222032.GA1055@steel.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alex Riesen wrote:

>Alex Riesen, Mon, Aug 25, 2003 12:29:33 +0200:
>  
>
>>Nick Piggin, Mon, Aug 25, 2003 12:27:14 +0200:
>>    
>>
>>>If you have some spare time perhaps you could test my scheduler
>>>patch.
>>>      
>>>
>>i'll try to. Can't promise to have it today, though.
>>
>>    
>>
>
>tried 7a. What I noticed first, is that the problem with rxvt eating up
>all cpu time is gone :) Also applications get less priorities (11-16).
>Can't say everything is very smooth, but somehow it makes very good
>impression. No really rough edges, but I have to admit I tried only pure
>cpu load (bash -c 'while :; do :; done').
>Applications feel to start faster (subjective).
>X was/is not niced.
>  
>

Thanks.. try renicing X to -10 or even -20.


