Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUB0WBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUB0V7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:59:39 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:14014 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263161AbUB0V51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:57:27 -0500
Message-ID: <403FBD46.2060807@cyberone.com.au>
Date: Sat, 28 Feb 2004 08:57:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D7C7D.5090902@matchmail.com> <403F9433.5070009@matchmail.com>
In-Reply-To: <403F9433.5070009@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Mike Fedyk wrote:
>
>> Nick Piggin wrote:
>>
>>> IMO, shrink_slab-for-all-zones.patch and zone-balancing-fix.patch
>>> should be all you need although they won't shrink the slab as
>>> much as mm3. They should be pretty easy to port by hand.
>>
>>
>>
>> How does this patch for 2.6.3 look?
>
>
> Never mind, I was brain dead at the time.
>
> This one should be better.
>

That should help, yes.

