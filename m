Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWEHO6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWEHO6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWEHO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:58:36 -0400
Received: from wip-ec-mm01.wipro.com ([203.91.193.25]:42956 "EHLO
	wip-ec-mm01.wipro.com") by vger.kernel.org with ESMTP
	id S932350AbWEHO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:58:36 -0400
Message-ID: <445F5DF1.3020606@wipro.com>
Date: Mon, 08 May 2006 20:34:17 +0530
From: Madhukar Mythri <madhukar.mythri@wipro.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to read BIOS information
References: <445F5228.7060006@wipro.com> <1147099994.2888.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1147099994.2888.32.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Mon, 2006-05-08 at 19:44 +0530, Madhukar Mythri wrote:
>  
>
>>Hi,
>>     Im new to this group.
>>I want to get some information from BIOS. i.e i want to know whether 
>>Hyperthreading is Enabled/Disabled(as per BIOS settings)  from an user 
>>applications program.
>>    
>>
>
>there is no standard way to do this. You can use /proc/cpuinfo to see if
>the kernel found ht'd processors. But that's the best you can do.
>(well you could grovel through the acpi tables just like the kernel
>does, but you really don't want to do that from userspace)
>
>
>  
>
"proc/cpuinfo" says only HT support is their or not but, it will not say 
whether HT is Enalbled/Disabled..
How to read ACPI tables ? Can  you give little info on this...
even from Driver program, if its possible please tell me...


-- 
Thanks & Regards
Madhukar Mythri
Wipro Technologies
Bangalore.
Off: +91 80 30294361.
M: +91 9886442416.

