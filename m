Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUIMJYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUIMJYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUIMJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:24:42 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:27584 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S266474AbUIMJYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:24:08 -0400
Message-ID: <4145672F.7060603@inet6.fr>
Date: Mon, 13 Sep 2004 11:23:59 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Linux-IDE <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <200409102321.17042.bzolnier@elka.pw.edu.pl> <4142D3AE.5050602@inet6.fr> <200409111802.45628.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409111802.45628.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Trusted: [ ip=62.210.105.37 rdns=ppp3290-cwdsl.fr.cw.net 
	helo=proxy.inet6-interne.fr by=smtp.ies.inet6.fr ident= ] [ 
	ip=192.168.50.116 rdns=bouton.inet6-interne.fr helo=!192.168.50.116! 
	by=proxy.inet6-interne.fr ident= ]
X-Spam-DCC: NIET: web01.inet6.ies 1080; IP=ok Body=1 Fuz1=1 Fuz2=1
X-Spam-Assassin: No hits=0.2 required=4.5
X-Spam-Untrusted: 
X-Spam-Pyzor: Reported 0 times.
X-Spam-Report: *  0.2 AWL AWL: Auto-whitelist adjustment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote the following on 09/11/2004 06:02 PM :

>>In fact I think I'm only a speed bumper here. There's so little work to 
>>do on the sis5513 driver now that I don't follow IDE work closely 
>>anymore and must refresh my memories even for such simple patches. I 
>>believe there are people around more fit than me for sis5513 maintenance.
>>    
>>
>
>I'm not aware of any such person...
>
>  
>

Vojtech seemed quite proficient at sis5513.c hacking :-)

>
>Dedicated maintainers are very useful even for legacy drivers.
>This way the subsystem maintainer doesn't have to worry about
>every fscking driver (less bugs, faster development). :-)
>
>  
>

Ok, if you think a dedicated maintainer is the way to go, I'll continue 
to review occasional patches. In fact I enjoy doing this from time to 
time, I was merely worried about not being the best fit for the job anymore.

Regards,

Lionel.
