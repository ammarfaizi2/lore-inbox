Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUIKKaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUIKKaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUIKKaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:30:18 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:27043 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S268081AbUIKKaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:30:10 -0400
Message-ID: <4142D3AE.5050602@inet6.fr>
Date: Sat, 11 Sep 2004 12:30:06 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Linux-IDE <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <1094828803.13450.4.camel@thomas.tec.linutronix.de> <4141C8C6.1030307@inet6.fr> <200409102321.17042.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409102321.17042.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Trusted: [ ip=62.210.105.37 rdns=ppp3290-cwdsl.fr.cw.net 
	helo=proxy.inet6-interne.fr by=smtp.ies.inet6.fr ident= ] [ 
	ip=192.168.50.116 rdns=bouton.inet6-interne.fr helo=!192.168.50.116! 
	by=proxy.inet6-interne.fr ident= ]
X-Spam-DCC: sgs_public_dcc_server: web01.inet6.ies 1199; Body=1 Fuz1=1 Fuz2=1
X-Spam-Assassin: No hits=0.2 required=4.5
X-Spam-Untrusted: 
X-Spam-Pyzor: Reported 0 times.
X-Spam-Report: *  0.2 AWL AWL: Auto-whitelist adjustment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote the following on 09/10/2004 11:21 PM :

>>I see it's not really a cutting-edge design (2002). Apparently nobody 
>>seemed to care about Linux IDE performance before :-|
>>    
>>
>
>Yep. :/  Lionel, can I push this fix upstream?
>  
>

Please do.

In fact I think I'm only a speed bumper here. There's so little work to 
do on the sis5513 driver now that I don't follow IDE work closely 
anymore and must refresh my memories even for such simple patches. I 
believe there are people around more fit than me for sis5513 maintenance.
With SATA, sis5513.c will soon be considered legacy code. I don't think 
a dedicated maintainer is usefull anymore, seems to me it would be 
better handled by someone with a broader view of IDE chipsets than me.

Any volunteeer ?

Lionel.
