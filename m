Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUIJPbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUIJPbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUIJPbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:31:35 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:20121 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S267370AbUIJPba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:31:30 -0400
Message-ID: <4141C8C6.1030307@inet6.fr>
Date: Fri, 10 Sep 2004 17:31:18 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>	 <4141BFDF.1050200@inet6.fr> <1094828803.13450.4.camel@thomas.tec.linutronix.de>
In-Reply-To: <1094828803.13450.4.camel@thomas.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Trusted: [ ip=62.210.105.37 rdns=ppp3290-cwdsl.fr.cw.net 
	helo=proxy.inet6-interne.fr by=smtp.ies.inet6.fr ident= ] [ 
	ip=192.168.50.116 rdns=bouton.inet6-interne.fr helo=!192.168.50.116! 
	by=proxy.inet6-interne.fr ident= ]
X-Spam-DCC: dmv.com: web02.inet6.ies 1181; Body=1 Fuz1=1 Fuz2=1
X-Spam-Assassin: No hits=0.2 required=4.5
X-Spam-Untrusted: 
X-Spam-Pyzor: Reported 0 times.
X-Spam-Report: *  0.2 AWL AWL: Auto-whitelist adjustment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote the following on 09/10/2004 05:06 PM :

>On Fri, 2004-09-10 at 16:53, Lionel Bouton wrote:
>  
>
>> [...]
>>
>> What hardware did you use to test ?
>>    
>>
>
>Compact PCI ICP-P4 from Inova Computers.
>
>  
>

I see it's not really a cutting-edge design (2002). Apparently nobody 
seemed to care about Linux IDE performance before :-|

