Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWIGDJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWIGDJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWIGDJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:09:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48359 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751807AbWIGDJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:09:04 -0400
Message-ID: <44FF8D40.2040504@in.ibm.com>
Date: Thu, 07 Sep 2006 08:38:48 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru>  <44FF1EE4.3060005@in.ibm.com> <1157580371.31893.36.camel@linuxchandra>
In-Reply-To: <1157580371.31893.36.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-09-07 at 00:47 +0530, Balbir Singh wrote:
> 
> <snip>
>> Some not quite so urgent ones - like support for guarantees. I think this can
> 
> IMO, guarantee support should be considered to be part of the
> infrastructure. Controller functionalities/implementation will be
> different with/without guarantee support. In other words, adding
> guarantee feature later will cause re-implementations.

Thanks for pointing this out. Thats what I implied in the comment below.

> 
>> be worked out as we make progress.
>>
>>> I agree with these requirements and lets move into this direction.
>>> But moving so far can't be done without accepting:
>>> 1. core functionality
>>> 2. accounting
>>>
>> Some of the core functionality might be a limiting factor for the requirements.
>> Lets agree on the requirements, I think its a great step forward and then
>> build the core functionality with these requirements in mind.
>>
>>> Thanks,
>>> Kirill
>>>


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
