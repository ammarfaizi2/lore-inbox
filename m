Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290650AbSARKHG>; Fri, 18 Jan 2002 05:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290649AbSARKG5>; Fri, 18 Jan 2002 05:06:57 -0500
Received: from mail011.syd.optusnet.com.au ([203.2.75.173]:23778 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S290648AbSARKGk>; Fri, 18 Jan 2002 05:06:40 -0500
Message-ID: <3C47F38C.5070402@dingoblue.net.au>
Date: Fri, 18 Jan 2002 21:06:04 +1100
From: Nero <neroz@dingoblue.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: o(1) to the rescue
In-Reply-To: <20020118030630.AA34757D57@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:

>Try this with and without the o(1) scheduler (J0).
>
>Create a dir full of 1 meg or so jpegs.  Fire up kde.  Try using the Tools/Create image gallery.  
>With the standard scheduler linux is unusable - it stalls for most of the processing time for 
>each image.   With o(1) its just a little jerky - still usable though (a gallery is building as I 
>type this).  
>
>Xmms playing to a arts server running with real time priority experienced no dropouts during 
>the process.
>
>This is on 2.4.17 no preempt or low latency patches applied.
>
>Real improvement - nice work,
>
>Ed Tomlinson
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



