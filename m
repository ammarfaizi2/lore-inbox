Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUBZCsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUBZCsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:48:43 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:2765 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262608AbUBZCsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:48:39 -0500
Message-ID: <403D5E79.5040508@matchmail.com>
Date: Wed, 25 Feb 2004 18:48:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D5B4C.3020309@matchmail.com> <403D5CB1.50409@cyberone.com.au>
In-Reply-To: <403D5CB1.50409@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>>
>> OK, I'll give that a try.
>>
>> Is the attached patch the latest version of your alternative patch 
>> instead of shrink_slab-for-all-zones.patch?
>>
> 
> Yes that looks like it. I am actually starting to like this patch
> again 

Didn't you like what you wrote in the first place ;)

> now that lowmem is being properly scanned as a result of
> highmem scanning.

That's what zone-balancing-fix.patch does, right?

Mike
