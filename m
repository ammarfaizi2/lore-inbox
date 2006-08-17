Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWHQQSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWHQQSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHQQSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:18:23 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:25297 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932555AbWHQQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:18:22 -0400
Message-ID: <44E4971F.2000903@rebelhomicide.demon.nl>
Date: Thu, 17 Aug 2006 18:19:43 +0200
From: Michiel de Boer <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Anonymous User <anonymouslinuxuser@gmail.com>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Patrick McFarland <diablod3@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: GPL Violation?
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <40d80630608170758h801504boebb92563238d8b06@mail.gmail.com>
In-Reply-To: <40d80630608170758h801504boebb92563238d8b06@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous User wrote:
> On 8/16/06, Anonymous User <anonymouslinuxuser@gmail.com> wrote:
>> I work for a company that will be developing an embedded Linux based
>> consumer electronic device.
>>
>> I believe that new kernel modules will be written to support I/O
>> peripherals and perhaps other things.  I don't know the details right
>> now.  What I am trying to do is get an idea of what requirements there
>> are to make the source code available under the GPL.
>>
>> I suspect the company will try to get away with releasing as little as
>> possible.  I don't know much about the GPL or Linux kernel internals,
>> but I want to encourage the company I work for to give back to the
>> community.
>>
>> I understand that modifications to GPL code must be released under the
>> GPL.  So if they tweak a scheduler implementation, this must be
>> released.  What if a new driver is written to support a custom piece
>> of hardware?  Yes, the driver was written to work with the Linux
>> kernel, but it isn't based off any existing piece of code.
>>
>> I'm posting anonymously because the company probably wouldn't want me
>> discussing this at all  :(
>
>
> Thanks to everyone who has responded to my question so far.
>
> It seems like the two issues that need to be addressed are:
> 1) Are the kernel modules being developed derived works?  If they are,
> they must be released along with the entire kernel source.
> 2) If they are not derived works, and shipped in a product, does the
> fact that they are shipped in a product that uses the linux kernel
> require that the new modules be licensed under the GPL?
>
> Yes, I agree that the company I work for should talk to a lawyer.  I
> however, am not interested in picking up a big legal tab to satisfy my
> curiosity.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
I suggest you take a look at http://gpl-violations.org/

Regards, Michiel de Boer

