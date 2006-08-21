Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWHUQaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWHUQaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWHUQaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:30:10 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:65425 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1422666AbWHUQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:30:08 -0400
Message-ID: <44E9E6A9.2030803@wolfmountaingroup.com>
Date: Mon, 21 Aug 2006 11:00:25 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: ndiswrapper]
References: <44E9D0FB.4000806@wanadoo.fr> <44E9DD89.4030106@wolfmountaingroup.com> <44E9DA18.1010602@wanadoo.fr>
In-Reply-To: <44E9DA18.1010602@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:

> I rebuilt ndiswrapper 1.19 version. When I type make, I have these 
> errors :
>
> /usr/src/kernel-headers-2.6.17.060815.dell/Ach/i386/Makefile:383 
> /usr/src/kernel-headers-2.6.17.060815.dell/Ach/i386/Makefile.cpu : No 
> file or folder of this type
> Not rules to built the target
>
> (I traduce from french)
>
> Jeff V. Merkey a écrit :
>
>> Hulin Thibaud wrote:
>>
>>> Hi !
>>> I wanted to write at the kernel-net list, but that don't works.
>>> I updated my kernel and compiled it to 2.6.17, but now, ndiswrapper
>>> don't recognize my dongle Thomson XG-1500A.
>>> What can I do ?
>>> Thanks you very much,
>>> Thibaud.
>>>
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>> Use the .19 ndiswrapper and try rebuilding.
>> Jeff
>>
>>
>
>
Sounds like the kernel includes and sources are not fully installed.  
Don't rely on stock kernels for any of the distros, go the the provider 
and get the kernel andall the header sources.

Jeff
