Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWHCTO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHCTO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHCTO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:14:58 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:54734 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932204AbWHCTO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:14:57 -0400
Message-ID: <44D24B31.2080802@vmware.com>
Date: Thu, 03 Aug 2006 12:14:57 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com>
In-Reply-To: <20060803190327.GA14237@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 03, 2006 at 11:08:04AM -0700, Zachary Amsden wrote:
>   
>> Perhaps we can use this to encourage open sourced firmware layers,
>> instead of trying to ban drivers which rely on firmware from the
>> kernel.
>>     
>
> No one is trying to ban such drivers.  Well, except the odd people on
> debian-legal, but all the kernel developers know to ignore them :)
>   

That is good to know.  But there is a kernel option which doesn't make 
much sense in that case:

[*] Select only drivers that don't need compile-time external firmware


Zach

