Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbULUNbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbULUNbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULUNbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:31:24 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:60653 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261756AbULUNbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:31:16 -0500
Message-ID: <41C82587.6030705@tiscali.de>
Date: Tue, 21 Dec 2004 14:30:47 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cyrix 6x86 Comma Bug 2.6
References: <41C41A04.8030009@tiscali.de>	 <200412210026.17426.vda@port.imtp.ilyichevsk.odessa.ua> <1103588598.32550.1.camel@localhost.localdomain>
In-Reply-To: <1103588598.32550.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2004-12-20 at 22:26, Denis Vlasenko wrote:
>  
>
>>It is very unlikely that you see "Coma" bug. It can be triggered only
>>by deliberately coded tight endless loop. "Ugly tokens on the screen"
>>suggest that you see something else.
>>    
>>
>
>Presumably those tokens included "Oops" somewhere near the top and
>function names. The Cyrix stuff is notoriously hard to keep cool so that
>may be a good thing to check, as well as running memtest86+ to check the
>RAM.
>
>Also some very early stepping 6x86 Cyrixes simply don't run Linux
>reliably and it seemed to be cache problems in the CPU.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
The problem wasn't the comma bug, one of the pci slots is broken. But 
thanks for your interest.

Sincerely
Matthias-Christian Ott
