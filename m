Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTFMPv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbTFMPv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:51:56 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:58353 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265421AbTFMPve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:51:34 -0400
Message-ID: <3EE9F636.6090900@mvista.com>
Date: Fri, 13 Jun 2003 09:05:10 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com>	 <20030612150335.6710a94f.akpm@digeo.com> <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan
Thanks didn't see that patch come by.  I'll have a look

-steve

Alan Cox wrote:

>On Iau, 2003-06-12 at 23:03, Andrew Morton wrote:
>  
>
>>This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
>>very interested in reading an outline of how you propose fixing it, without
>>waiting until OLS, thanks.
>>    
>>
>
>Dave Miller posted a simple patch to allow netlink to be used for
>kernel->user messages - hotplug/disk error/logging/whatever. I'm
>suprised therefore that the whole thing is being regurgitated again.
>
>
>
>
>  
>

