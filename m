Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVANNSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVANNSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVANNSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 08:18:07 -0500
Received: from mail.outpost24.com ([212.214.12.146]:46294 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S261981AbVANNSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:18:00 -0500
Message-ID: <41E7E308.2080504@outpost24.com>
Date: Fri, 14 Jan 2005 16:19:36 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.4.20-18.7smp bug
References: <200501140901.j0E91Lk07957@adf141.allyes.com>	 <1105695993.6080.25.camel@laptopd505.fenrus.org>	 <41E7E008.7040603@outpost24.com> <1105708214.6042.12.camel@laptopd505.fenrus.org>
In-Reply-To: <1105708214.6042.12.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well sorry for not making me clear, i forgot to say that
im not using 2.4.20 or any other default kernel. Im using
2.6.10 from kernel.org.

the "vulnerability" im talking about is the following:

http://www.isec.pl/vulnerabilities/isec-0022-pagefault.txt


Best regards
David Jacoby


Arjan van de Ven wrote:

>On Fri, 2005-01-14 at 16:06 +0100, David Jacoby wrote:
>  
>
>>Hi everyone...
>>
>>Does anyknow know if there is  patch for this vulnerability?
>>    
>>
>
>"vulnerability" ???
>
>You first need to go to far far more recent kernel (the fedora-legacy
>project keeps providing kernel updates for the otherwise End Of Life
>RHL7.x series), and the kernel is tainted by a binary module so you want
>to try without that first as well.
>
>
>  
>

