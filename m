Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHTSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHTSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268632AbUHTSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:08:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:11956 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268602AbUHTSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:04:56 -0400
Message-ID: <41263D4C.6060907@namesys.com>
Date: Fri, 20 Aug 2004 11:05:00 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: Andrew Morton <akpm@osdl.org>, cherry@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.8.1-mm2
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092927166.29916.0.camel@cherrybomb.pdx.osdl.net> <4125A2F6.5050308@namesys.com> <20040820001629.387715be.akpm@osdl.org> <4125AA35.6020900@namesys.com> <20040820135321.GY5154@backtop.namesys.com>
In-Reply-To: <20040820135321.GY5154@backtop.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:

>
>yes. there are large objects (reiser4 context, balancing pools, ...) which
>reiser4 allocates on stack. we will use kmalloc/slab for them and see how
>performance is changed.  not trivial things will be required if those fixes
>would not enough.
>
>  
>
>>Hans
>>    
>>
>
>  
>
Ok, go for it.

Hans
