Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVANUGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVANUGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVANUGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:06:05 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31974 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262061AbVANUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:05:46 -0500
Message-ID: <41E8260E.2020806@comcast.net>
Date: Fri, 14 Jan 2005 14:05:34 -0600
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/4] relayfs for 2.6.10: headers
References: <41E736C4.3080806@opersys.com> <20050114190725.GA15337@kroah.com>
In-Reply-To: <20050114190725.GA15337@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 13, 2005 at 10:04:36PM -0500, Karim Yaghmour wrote:
> 
>>--- linux-2.6.10/include/linux/klog.h	1969-12-31 16:00:00.000000000 -0800
>>+++ linux-2.6.10-relayfs/include/linux/klog.h	2005-01-13 10:40:25.000000000 -0800
>>@@ -0,0 +1,24 @@
>>+/*
>>+ * KLOG		Generic Logging facility built upon the relayfs infrastructure
> 
> 
> Why is this header in the relayfs code?  Shouldn't it be a separate
> patch?

Yes, you're right - I'll separate it out.

Thanks,

Tom

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

