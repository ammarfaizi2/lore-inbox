Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUCGAnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 19:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCGAnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 19:43:20 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:55263 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261517AbUCGAnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 19:43:18 -0500
Message-ID: <404A7021.309@cyberone.com.au>
Date: Sun, 07 Mar 2004 11:43:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: akpm@osdl.org, mfedyk@matchmail.com,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: nicksched v30
References: <4048204E.8000807@cyberone.com.au>	 <1078488995.13256.1.camel@midux>  <4049485B.3070104@cyberone.com.au> <1078573144.1850.7.camel@midux>
In-Reply-To: <1078573144.1850.7.camel@midux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Hästbacka wrote:

>On Sat, 2004-03-06 at 05:41, Nick Piggin wrote:
>
>>Unfortunately not. The scheduler in -mm is different enough
>>that porting isn't straightfoward.
>>
>>What does mm break for you?
>>
>I don't know about the current, but one or two versions back when I
>tested the last time it printed something about unknown key for the
>whole dmesg and couldn't find /dev/hd{b,c}. After investigations the
>hard-drives had changed place for some reason (Not swapped place, but
>they were in a weird location, can't recall which).
>
>I'll try the new one when I have time to boot this one.
> 
>

That would be good. Most stuff in mm is slated to get into the
official tree sooner or later, so finding problems sooner is
obviously preferable. Thanks


