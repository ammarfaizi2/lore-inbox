Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWHCSIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWHCSIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWHCSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:08:06 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:47063 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932223AbWHCSIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:08:05 -0400
Message-ID: <44D23B84.6090605@vmware.com>
Date: Thu, 03 Aug 2006 11:08:04 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org>
In-Reply-To: <1154603822.2965.18.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Hi,
>
> you use a lot of words for saying something self contradictory. It's
> very simple; based on your mail, there's no reason the VMI gateway page
> can't be (also) GPL licensed (you're more than free obviously to dual,
> tripple or quadruple license it). Once your gateway thing is gpl
> licensed, your entire proposal is moot in the sense that there is no
> issue on the license front. See: it can be very easy. Much easier than
> trying to get a license exception (which is very unlikely you'll get)...
>
>
> Now you can argue for hours about if such an interface is desirable or
> not, but I didn't think your email was about that.
>   

Arjan, thank you for reading my prolific manifesto.  I am not arguing 
for the interface being desirable, and I don't think I'm being self 
contradictory.  There was some confusion over technical details of the 
VMI gateway page that I wanted to make explicit.  Hopefully I have fully 
explained those.  I'm not trying to get a license exemption, I'm trying 
to come up with a model that current and future hardware vendors can 
follow when faced with the same set of circumstances.

It was not 100% clear based on conversations at OLS that open-sourcing 
the VMI layer met the letter and intent of the kernel license model.  
There were some arguments that not having the source integrated into the 
kernel violated the spirit of the GPL by not allowing one to distribute 
a fully working kernel.  I wanted to show that is not true, and the 
situation is actually quite unique.  Perhaps we can use this to 
encourage open sourced firmware layers, instead of trying to ban drivers 
which rely on firmware from the kernel.

Zach
