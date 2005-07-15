Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263261AbVGOJeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbVGOJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGOJeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:34:08 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:23426
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263261AbVGOJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:32:34 -0400
Message-ID: <42D781B9.4080506@prodmail.net>
Date: Fri, 15 Jul 2005 14:58:25 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: omb@bluewin.ch, linux-kernel@vger.kernel.org
Subject: Re: Buffer Over-runs, was Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>	 <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>	 <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>	 <42D6ECED.7070504@khandalf.com>  <42D75A93.5010904@prodmail.net>	 <1121410260.3179.3.camel@laptopd505.fenrus.org>	 <42D7734D.9070204@prodmail.net> <1121417215.3179.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1121417215.3179.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Fri, 2005-07-15 at 13:56 +0530, RVK wrote:
>  
>
>>>except this is no longer true really ;)
>>>
>>>randomisation for example makes this a lot harder to do.
>>>gcc level tricks to prevent buffer overflows are widely in use nowadays
>>>too (FORTIFY_SOURCE and -fstack-protector). The combination of this all
>>>makes it a LOT harder to actually exploit a buffer overflow on, say, a
>>>distribution like Fedora Core 4.
>>>
>>>
>>>
>>>
>>>      
>>>
>>Still is very new....not every one can immediately start using gcc 4.
>>    
>>
>
>it;s also available for gcc 3.4 as patch (and included in FC3 and RHEL4
>for example)
>
>so it's new? so what? doesn't make it less true that it nowadays is a
>lot harder to exploit such bugs on recent distros.
>  
>
Can I get more details on this patch for 3.4. Where can I find it ?

rvk

>.
>
>  
>

