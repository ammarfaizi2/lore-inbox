Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbTIIXzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTIIXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:55:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:33226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265005AbTIIXzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:55:10 -0400
Message-Id: <200309092353.h89NrTN31627@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Nick Piggin <piggin@cyberone.com.au>
cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms 
In-Reply-To: Message from Nick Piggin <piggin@cyberone.com.au> 
   of "Tue, 09 Sep 2003 14:14:49 +1000." <3F5D53B9.8050004@cyberone.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Sep 2003 16:53:29 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  Nick Piggin wrote:

> Con Kolivas wrote:
> 

> Hi Con,
> Any chance you could give this
> http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
> a try? It should apply against test5.
> 
> 
I have some STP tests scheduled against this also (PLM 2117) 
Please let me know if you want other combinations tested - am just catching up 
on
this thread.
cliffw

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


