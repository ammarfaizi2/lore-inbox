Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVIUAXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIUAXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVIUAXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:23:20 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55187 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750815AbVIUAXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:23:19 -0400
Message-ID: <4330A7E1.7080502@namesys.com>
Date: Tue, 20 Sep 2005 17:22:57 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Roman I Khimov <rik@osrc.info>, reiserfs-list@namesys.com,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <200509202328.28501.rik@osrc.info> <20050920213728.GA1945@elf.ucw.cz> <200509210133.41710.rik@osrc.info> <20050920221037.GB1945@elf.ucw.cz>
In-Reply-To: <20050920221037.GB1945@elf.ucw.cz>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>>Second check...
>>>>e2fsck 1.34 (25-Jul-2003)
>>>>        
>>>>
>>>I have 1.38 here, so yours is too old.
>>>      
>>>
>>I'll compile something new tomorrow and try to retest it.
>> 
>>    
>>
>>>OTOH if reiser4 survives that for 80 cycles... that's pretty good.
>>>      
>>>
>>Actually 125 before I've got completely tired of HDD noise. :)
>>    
>>
>
>At tytso's request... could you put some reiser3 and reiser4
>filesystem images inside test data?
>								Pavel
>  
>
For V3 they will break things.  For V4, sure, let's test it, I'd like to
confirm that we fixed things.
