Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUIAKkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUIAKkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUIAKkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:40:51 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:49924 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S265928AbUIAKkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:40:49 -0400
Message-ID: <4135A834.50002@hist.no>
Date: Wed, 01 Sep 2004 12:45:08 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 Inconsistent kallsyms
References: <20040830235426.441f5b51.akpm@osdl.org>	<41343C0F.5020508@hist.no> <20040831020206.191c0d01.akpm@osdl.org>
In-Reply-To: <20040831020206.191c0d01.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Helge Hafting <helge.hafting@hist.no> wrote:
>  
>
>>This compiled, but failed anyway (after make mrproper):
>>
>>   LD      vmlinux
>>   SYSMAP  System.map
>>   SYSMAP  .tmp_System.map
>> Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
>>    
>>
>
>It can happen I guess, depending on which way the wind was blowing when
>your binutils was released.
>
>Do you try doing what it said?
>  
>
I tried it, and it worked.  This is posted using 2.6.9-rc1-mm2

Helge Hafting
