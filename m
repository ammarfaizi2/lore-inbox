Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTIJCNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTIJCNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:13:51 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:43017
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264478AbTIJCNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:13:49 -0400
Message-ID: <3F5E8897.7040302@cyberone.com.au>
Date: Wed, 10 Sep 2003 12:12:39 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <200309092353.h89NrTN31627@mail.osdl.org>
In-Reply-To: <200309092353.h89NrTN31627@mail.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cliff White wrote:

>> Nick Piggin wrote:
>>
>
>>Con Kolivas wrote:
>>
>>
>
>>Hi Con,
>>Any chance you could give this
>>http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
>>a try? It should apply against test5.
>>
>>
>>
>I have some STP tests scheduled against this also (PLM 2117) 
>Please let me know if you want other combinations tested - am just catching up 
>on
>this thread.
>cliffw
>

Thanks Cliff that would be cool. If you could test  this: 
http://www.kerneltrap.org/~npiggin/v14/sched-rollup-v14.gz
as well would be good. The previous one is more important though.

