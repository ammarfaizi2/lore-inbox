Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVC0Tv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVC0Tv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVC0Tv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:51:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:34484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261494AbVC0TvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:51:24 -0500
Message-ID: <42470E99.7010304@osdl.org>
Date: Sun, 27 Mar 2005 11:50:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
References: <200503271554.44382.eike-kernel@sf-tec.de> <20050327213124.1e82828b.khali@linux-fr.org> <200503272145.10266.eike-kernel@sf-tec.de>
In-Reply-To: <200503272145.10266.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Jean Delvare wrote:
> 
>>Hi Eike,
>>
>>
>>>Trivial typo fix.
>>>(...)
>>> Force the probing code to probe EISA slots even when it cannot find an
>>>-EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
>>>+EISA compliant mainboard (nothing appears on slot 0). Default to 0
>>> (don't force), and set to 1 (force probing) when either
>>> CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
>>
>>Wouldn't it rather be "Defaults"?
> 
> 
> Damn, yes. Every time I read it again I feel a little bit more comfortable 
> with s/are set/is set/. Am I right or is it already too late for useful 
> work?

Defaults

when either FOO or BAR is set.

and the comma after (don't force) shouldn't be there...

-- 
~Randy
