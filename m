Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269037AbUIXWzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269037AbUIXWzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUIXWzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:55:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10895 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269031AbUIXWyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:54:35 -0400
Message-ID: <4154A655.9040302@austin.ibm.com>
Date: Fri, 24 Sep 2004 17:57:25 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <16723.43493.796084.90914@wombat.chubb.wattle.id.au>
In-Reply-To: <16723.43493.796084.90914@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>>>>>>"Andrew" == Andrew Morton <akpm@osdl.org> writes:
>>>>>>            
>>>>>>
>
>Andrew> Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>> The readahead code has undergone many changes in the 2.6 kernel
>>>and the current implementation is in my opinion obtuse and hard to
>>>maintain.
>>>      
>>>
>
>Andrew> It did get a bit ugly - it was intially designed to handle
>Andrew> pagefault readaround and perhaps could be further simplified
>Andrew> as we're now doing that independently.
>
>If you're coding up new readahead schemes, it may be worth taking into
>account Papathanasiou and Scott, `Energy Efficient Prefetching and
>Caching'
>( http://www.usenix.org/events/usenix04/tech/general/papathanasiou/papathanasiou_html/index.html
>)
>  
>
Have not had time to look into this yet, but I will.  

Thanks, Steve


