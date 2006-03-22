Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWCVO3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWCVO3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCVO3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:29:32 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:5614 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750718AbWCVO3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:29:31 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOECJKOAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKOECJKOAB.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <09c1c7b16157385a7f8d6ace16d91959@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
Date: Wed, 22 Mar 2006 14:29:48 +0000
To: davids@webmaster.com
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 11:32, David Schwartz wrote:

>> I thought GPLv2 would be implicit. I'll add the short GPL stanza to
>> each of the offending source files.
>
> 	It seems rather illogical to me to add a GPL stanza. The GPL adds new
> rights and imposes requirements on you only if you could get those 
> rights no
> other way. Since there is another way, the alternative license, the GPL
> requirements would never kick in. Although, as far as I can tell, it 
> doesn't
> change or harm anything.

Yes, that's the same logic I applied. I think it is redundant, but I 
think it makes sense to add a sentence to the effect that the file is 
GPL if you want it to be, just to avoid any fears or complaints, and to 
show that we really aren't trying to do anything fishy. And IANAL so 
I'll err on the side of caution and redundancy. :-)

  -- Keir

