Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWHDO5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWHDO5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWHDO5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:57:16 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:30042 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161210AbWHDO5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:57:15 -0400
Message-ID: <44D3603D.90802@sw.ru>
Date: Fri, 04 Aug 2006 18:57:01 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu
 controller
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain>
In-Reply-To: <1154684950.23655.178.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>The downside to such a strategy is that there is a risk that nobody ever
>>gets around to implementing useful controllers, so it ends up dead code. 
>>I'd judge that the interest in resource management is such that the risk of
>>this happening is low.
> 
> 
> I think the risk is that OpenVZ has all the controls and resource
> managers we need, while CKRM is still more research-ish. I find the
> OpenVZ code much clearer, cleaner and complete at the moment, although
> also much more conservative in its approach to solving problems.

Alan, I will be happy to hear what you mean by conservative :)
Maybe we can make it more revolutinary then.

Kirill

