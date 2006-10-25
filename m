Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWJYTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWJYTJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161376AbWJYTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:09:22 -0400
Received: from 8.ctyme.com ([69.50.231.8]:38326 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1161374AbWJYTJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:09:22 -0400
Message-ID: <453FB661.3020607@perkel.com>
Date: Wed, 25 Oct 2006 12:09:21 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
References: <453EEE46.9040600@perkel.com> <p73vem8kyuv.fsf@verdi.suse.de>
In-Reply-To: <p73vem8kyuv.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:
> Marc Perkel <marc@perkel.com> writes:
>
>   
>> Ok - I had a bad day today struggling with hardware. Having said that
>> I'm somewhat frustrated with the lack of progress of Linux getting it
>> right with Asus, nVidia, and AMD processors right.
>>
>> I still have to run pci=nommconf to keep the server from locking
>> up. That's with both 939 pin and AM2 motherboards.
>>
>> This bug remains unresolved:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=6975
>>
>> So what's up with the no progress?
>>     
>
> The bug report only references ancient kernels (2.6.15, 2.6.17) How do you know there is no
> progress?
>
> -Andi
>   
As of the 2.6.18 released kernel I still had to modify the source code 
to keep the kernel from locking up on boot. I haven't tried it with 
2.6.19rcx yet.

