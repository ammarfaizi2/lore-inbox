Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWGHDqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWGHDqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWGHDqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:46:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20438 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932496AbWGHDqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:46:53 -0400
Message-ID: <44AF2AA9.9030205@us.ibm.com>
Date: Fri, 07 Jul 2006 20:46:49 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, Reuben Farrelly <reuben-lkml@reub.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44AE268F.7080409@reub.net>	<20060707023518.f621bcf2.akpm@osdl.org>	<44AECEDD.201@reub.net> <20060707143854.4a8fd106.akpm@osdl.org> <44AED530.8040802@mbligh.org>
In-Reply-To: <44AED530.8040802@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>
>> Yikes!  Until we fix that there's no point in looking at anything else.
>>
>> CONFIG_DEBUG_PAGEALLOC would nail this bug in a flash, but x86_64 
>> doesn't
>> implement the damn thing :(
>
> I have an implementation, but there's some bug in it I never fixed. If
> you want it, I'll update it  and send it out ... maybe you can spot the
> bug ;-(
>
Please send it out. I will take a look (not that I can fix it :)

Thanks,
Badari

