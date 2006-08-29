Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWH2Pwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWH2Pwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWH2Pwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:52:54 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:870 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965047AbWH2Pwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:52:54 -0400
Message-ID: <44F46396.5050601@sw.ru>
Date: Tue, 29 Aug 2006 19:56:06 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Devel] [PATCH 6/6] BC: kernel memory accounting (marks)
References: <44EC31FB.2050002@sw.ru>  <44EC371F.7080205@sw.ru>	 <1156357820.12011.45.camel@localhost.localdomain>  <44F40E76.5000809@sw.ru> <1156866525.5408.56.camel@localhost.localdomain>
In-Reply-To: <1156866525.5408.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-08-29 at 13:52 +0400, Kirill Korotaev wrote:
> 
>>1. we will introduce a separate patch moving this pointer
>>  into mirroring array
>>2. this pointer is still required for _user_ pages tracking,
>>  that's why I don't follow your suggestion right now... 
> 
> 
> You hadn't mentioned that part. ;)
I was crying about it 2 or 3 times :)
But no suprise that you hadn't notice that due to too many emails on BC.

> I guess we'll wait for the user patches before these can go any further.
:))) are you the one to decide? :) then lets drink some beer :)))

Thanks,
Kirill

