Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWHCWbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHCWbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCWbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 18:31:39 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23465 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932534AbWHCWbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 18:31:38 -0400
Message-ID: <44D2794A.0@vmware.com>
Date: Thu, 03 Aug 2006 15:31:38 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>	 <44D26D87.2070208@vmware.com> <1154644383.23655.142.camel@localhost.localdomain>
In-Reply-To: <1154644383.23655.142.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-03 am 14:41 -0700, ysgrifennodd Zachary Amsden:
>   
>> Hence my point follows.  Using source compiled with the kernel as a 
>> module does nothing to provide a stable interface to the backend 
>> hardware / hypervisor implementation.
>>     
>
> Could have fooled me. It seems to work for the IBM Mainframe people
> really well. 
>   

Yes, but not because of source compatibility.  It works because the 
hypervisor layer is actually architected in the hardware.

Zach
