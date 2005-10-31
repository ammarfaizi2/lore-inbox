Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVJaQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVJaQlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJaQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:41:17 -0500
Received: from jericho.hostgo.com ([216.218.220.34]:457 "EHLO
	jericho.hostgo.com") by vger.kernel.org with ESMTP id S932466AbVJaQlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:41:15 -0500
Message-ID: <43664912.1060703@mlfowler.com>
Date: Mon, 31 Oct 2005 16:40:50 +0000
From: Mike Fowler <linux-kernel@mlfowler.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ray-gmail@madrabbit.org
CC: patrizio.bassi@gmail.com, "Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <436638A8.3000604@gmail.com> <2c0942db0510310813p452b20b1q927e20376cd80ae0@mail.gmail.com>
In-Reply-To: <2c0942db0510310813p452b20b1q927e20376cd80ae0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This email message has been scanned for viruses
X-MailScanner-HostGo: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - jericho.hostgo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - mlfowler.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ray Lee wrote:
> On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> 
>>starting from 2.6.0 (2 years ago) i have the following bug.
> 
> 
> Well, the problem probably started before then.
> 
> 
>>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
> 
> 
>>Please fix that...2 years' bug!
> 
> 
> Speaking as a programmer, that's not a lot to go off of to find the
> bug. I think everyone would agree it's a bug, but we'll need more help
> from you.
> 
> 
>>fast summary:
>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>file) i hear noises, related to disk activity. more hd is used, more chicks
>>and ZZZZ noises happen.
> 

This to me sounds more like an interference issue, something I have seen 
on many laptops (I used to repair them in a previous incarnation). It is 
often referred to as "the 50Hz/60Hz hum" or the "ground loop" see any of 
these:

-http://www.pcmus.com/power-grounding.htm
-http://en.wikipedia.org/wiki/Ground_loop_%28electricity%29

-- 
Mike Fowler
Registered Linux user: 379787

"I could be a genius if I just put my mind to it, and I,
I could do anything, if only I could get 'round to it"
-PULP 'Glory Days'
