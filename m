Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVJOBnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVJOBnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJOBnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:43:15 -0400
Received: from 10.ctyme.com ([69.50.231.10]:37577 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1751009AbVJOBnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:43:14 -0400
Message-ID: <43505EAE.1020502@perkel.com>
Date: Fri, 14 Oct 2005 18:43:10 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops
References: <4350554F.7010503@perkel.com> <20051014182118.30c7d947.rdunlap@xenotime.net>
In-Reply-To: <20051014182118.30c7d947.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
X-Mail-from: marc@perkel.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's all the info I have at the moment. The server is still running. I 
tried trying to reboot it by typing reboot and it keeps running. 
Services won't shut down. But it's still processing email and filtering 
spam.




Randy.Dunlap wrote:

>On Fri, 14 Oct 2005 18:03:11 -0700 Marc Perkel wrote:
>
>  
>
>>What is this? Kernel 2.6.13.2 64 bit Dual Core Athlox X2
>>
>>Message from syslogd@pascal at Fri Oct 14 16:44:47 2005 ...
>>pascal kernel: Oops: 0000 [1] SMP
>>
>>Message from syslogd@pascal at Fri Oct 14 16:44:57 2005 ...
>>pascal kernel: CR2: 0000000000000800
>>    
>>
>
>It appears to be a Kernel Oops ($subject), but there's not
>enough of it listed here to determine what happened.
>
>See http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>or better:  linux/REPORTING-BUGS
>and linux/Documentation/oops-tracing.txt
>
>---
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
