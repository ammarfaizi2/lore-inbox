Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUBYTuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUBYTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:50:04 -0500
Received: from imap.gmx.net ([213.165.64.20]:61115 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261432AbUBYTt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:49:58 -0500
X-Authenticated: #4512188
Message-ID: <403CFC64.5020401@gmx.de>
Date: Wed, 25 Feb 2004 20:49:56 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       a.verweij@student.tudelft.nl
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
References: <200402120122.06362.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au> <40395961.40608@gmx.de> <200402252238.55834.ross@datscreative.com.au>
In-Reply-To: <200402252238.55834.ross@datscreative.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> On Monday 23 February 2004 11:37, Prakash K. Cheemplavam wrote:
> 
>>Oh before I forget, I had to resolve a reject by hand, but I *think* I 
>>did it right. (And yes, I used your corrected versionof the patch.) 
>>Well, maybe you take a look over the patch and rediff. :-)
>>
>>Prakash
>>
>>
>>
> 
> 
> Hi Prakash,
> Patches attached rediffed for 2.6.3 and 2.6.3-mm3.

Hi Ross,

so I am running this patch now since you released it (5:21h) and so far 
stable. Temp is better, bt not as goos as pic mode (about 3-4°C higher). 
Nevertheless, nice work!

Thanks,

Prakash
