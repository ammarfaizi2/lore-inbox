Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVI3SMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVI3SMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVI3SMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:12:42 -0400
Received: from [85.21.88.2] ([85.21.88.2]:7339 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932556AbVI3SMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:12:41 -0400
Message-ID: <433D8010.1090701@ru.mvista.com>
Date: Fri, 30 Sep 2005 22:12:32 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Boyer <jdub@us.ibm.com>
CC: Pavel Machek <pavel@ucw.cz>, dwmw2@infradead.org,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [patch] switch mtd to new driver model & cleanups
References: <20050930121741.GA5506@elf.ucw.cz>	 <433D482A.1000708@ru.mvista.com> <1128089827.3111.2.camel@windu.rchland.ibm.com>
In-Reply-To: <1128089827.3111.2.camel@windu.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I've heard, there's gonna be a megre quite soon... :)
Anyway, I guess it'd be better if Pavel ntroduced the new patch against 
the latest linux-mtd code.

Best regards,
   Vitaly

Josh Boyer wrote:

>On Fri, 2005-09-30 at 18:14 +0400, Vitaly Wool wrote:
>  
>
>>Hi Pavel,
>>
>>it looks like your patch is not against the latest linux-mtd CVS sources 
>>since there's no such things as mtd_pm_dev in the current one. Please 
>>correct me if I'm mistaken.
>>    
>>
>
>I'm assuming Pavel is just fixing up what's in the mainline kernel.
>This happens quite often, since MTD doesn't sync all too much for
>various reasons.
>
>When a sync is done, stuff like this usually gets picked up in some form
>for the MTD CVS tree.  See the commit messages that say things like
>"Merge with upstream".
>
>josh
>
>
>  
>

