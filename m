Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTESUMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTESUMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:12:07 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:15232 "EHLO
	perryconsulting.net") by vger.kernel.org with ESMTP id S262771AbTESUMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:12:05 -0400
Message-ID: <3EC93D9B.1010307@perryconsulting.net>
Date: Mon, 19 May 2003 16:24:59 -0400
From: Arthur Perry <art@perryconsulting.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Sorry if this question is the beaten dead horse
References: <3EC92E0E.5090807@perryconsulting.net> <3EC936F7.1060207@perryconsulting.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

Since Slackware went to gcc-3.2.2 with the release of 9.0, I have been 
successfully building recent 2.4 kernels without any problems.

You guys probably already know this, but coming from another user.. It 
works for me.

Just did not occur to me that this may be my problem when compiling a 
2.5 kernel until I read what I wrote you  ;)


Arch: i686, Pentium III Coppermine




Arthur Perry wrote:
> Aww geesh.
> 
> I am such a fool.
> All I have to say is 'less ./Documentation/Changes'.
> I will give this a go first before I send another silly email.
> remember to RTFM.  ;)
> 
> Sorry about that.
> 
> Been a while since I had to read the kernel user's readmes.
> 
> 
> 
> 
> Arthur Perry wrote:
> 
>> Hello All,
>>
>> I have a question, sorry if it is totally out of this league.
>> I have been trying to compile a 2.5 kernel with modules support for a 
>> while, and have always been unsuccessful.
>> There are always unresolved symbols.
>> Always. Tons of em. If I didn't know any better, I'd say all of them 
>> of which I tried to compile as modules.
>> I am not a newbie to Linux, I have been putting together distros for 
>> over 6 years, but the past year or two I have been maintaining stable 
>> releases in production environments.
>> Just recently, I have tried to build the 2.5 tree, adn I know I am 
>> missing something.
>>
>> I am using Slackware 9.0, which is glibc 2.3.1 and gcc 3.2.2.
>> Modutils 2.4.25 with Rusty's module-init-tools-0.9.12.
>> It is mostly Vanilla otherwise.
>>
>> I know I must be missing a lot of tools and system-side changes to 
>> accomodate a 2.5 kernel, and I have been trying to identify what they 
>> are.
>>
>> No need to get too specific, I have been categorically a kernel "user" 
>> for quite some time (just not a 2.5 one), so I just need quick info 
>> and links.
>>
>>
>> Thanks in advance!!
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


