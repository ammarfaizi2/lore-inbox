Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTLSUBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLSUBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:01:32 -0500
Received: from bm-3a.paradise.net.nz ([202.0.58.22]:19606 "EHLO
	linda-3.paradise.net.nz") by vger.kernel.org with ESMTP
	id S263573AbTLSUBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:01:31 -0500
Date: Sun, 21 Dec 2003 09:01:47 +1300
From: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Subject: Re: IDE issues
In-reply-to: <3FE2EFD5.6000009@inet6.fr>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>, linux-kernel@vger.kernel.org
Message-id: <3FE4AAAB.8000209@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105
 Thunderbird/0.3
References: <3FE43492.3020703@student.canterbury.ac.nz>
 <3FE2EFD5.6000009@inet6.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.0, as i said 2.6.0-test11 worked fine on this system running 
gentoo, and didn't run under debian... grrr...

Oh well, off to see if this helps...

--Oliver

Lionel Bouton wrote:

> Oliver Hunt wrote the following on 12/20/2003 12:37 PM :
>
>> I was using 2.6.0-test11 on a gentoo install on this system and my 
>> system worked fine, however that install died earlier this week, and 
>> now i'm running debian.  The configuration in gentoo didn't boot for 
>> debian so i reset everything from scratch.
>>
>> [...]
>
>
>
>> CONFIG_BLK_DEV_SIS5513=y
>>  
>>
> Might be either a too old kernel version without proper support for 
> your SiS chipset or shaky local APIC support.
> I suppose you use a 2.4 kernel with debian. Which version is it ?
> What is the chipset (or the motherboard) model ?
>


