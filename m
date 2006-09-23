Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWIWSzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWIWSzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWIWSzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:55:18 -0400
Received: from free-electrons.com ([88.191.23.47]:28331 "EHLO
	sd-2511.dedibox.fr") by vger.kernel.org with ESMTP id S1751429AbWIWSzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:55:16 -0400
Message-ID: <45158305.3010401@free-electrons.com>
Date: Sat, 23 Sep 2006 20:55:01 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in Documentation/DocBook
References: <200609212318.07418.michael-lists@free-electrons.com> <20060921150738.ed407645.rdunlap@xenotime.net>
In-Reply-To: <20060921150738.ed407645.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>>     <structfield>owner</structfield> field, such as in the
>>     <structname>file_operations</structname> structure. Set this field
>>     to the macro <symbol>THIS_MODULE</symbol>.
>> @@ -1028,7 +1028,7 @@ printk(KERN_INFO "my ip: %d.%d.%d.%d\n",
>>  
>>     <para>
>>      The preferred method of initializing structures is to use
>> -    designated initialisers, as defined by ISO C99, eg:
>> +    designated initializers, as defined by ISO C99, eg:
>>     
>
> UK spelling, it's OK.
>   

Thank you all very much for your reviews!

In this particular case, I chose the American spelling because it 
existed too in the same file (see 
http://lxr.free-electrons.com/source/Documentation/DocBook/kernel-hacking.tmpl#1098). 
I guess it is fine to have 2 different spellings for the same word in 
the same document, right? Otherwise, arbitrating between the 2 options 
can be pretty tricky.

>> diff -Nurp linux-2.6.18/Documentation/DocBook/libata.tmpl 
>> linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl
>> --- linux-2.6.18/Documentation/DocBook/libata.tmpl	2006-09-20 
>> 05:42:06.000000000 +0200
>> +++ linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl	2006-09-21 
>> 22:14:56.000000000 +0200
>>     
>
> ack all except "iff".  That is "if and only if".
>   
Oops, thanks for this reminder!

Cheers,

    Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

