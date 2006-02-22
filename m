Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWBVNSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWBVNSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWBVNSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:18:37 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:25052 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1750829AbWBVNSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:18:37 -0500
Message-ID: <43FC6515.5010800@qazi.f2s.com>
Date: Wed, 22 Feb 2006 13:20:21 +0000
From: Asfand Yar Qazi <ay0106@qazi.f2s.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
References: <5IWVb-7UA-11@gated-at.bofh.it> <5IYDF-20s-3@gated-at.bofh.it> <5J0Z7-5we-13@gated-at.bofh.it> <5J18z-5HB-21@gated-at.bofh.it> <5J1iu-5TF-27@gated-at.bofh.it>
In-Reply-To: <5J1iu-5TF-27@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asfand Yar Qazi wrote:
> Martin Mares wrote:
> 
>> Hello!
>>
>>
>>> OK, will try that.  decimal of octal(0164) = decimal(116)
>>
>>
>>
>> This won't work -- the mode numbers are hexadecimal, not octal.
>> Use 356 (decimal).
> 
> 
> You're right.  I thought '0164' was octal - 0 prefix.

It worked.

<snip>

>>
>>
>>
>> You can also try giving 0x164 to GRUB.
> 
> 
> I'll try that as well.
> 

It worked as well - obviously I'm using a newer version of GRUB.

Thanks.

