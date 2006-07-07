Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGGMhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGGMhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGGMhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:37:43 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:44737 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932148AbWGGMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:37:42 -0400
Message-ID: <44AE558D.9000906@linuxtv.org>
Date: Fri, 07 Jul 2006 08:37:33 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Linux 2.6.16.y series
References: <20060706222553.GA2946@kroah.com> <20060707105407.GA1654@elf.ucw.cz>
In-Reply-To: <20060707105407.GA1654@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Is it still okay to submit patches for 2.6.16-stable? I guess "dirty
>buffers flushing broken after resume" may count...
>								Pavel
>  
>
I was under the impression that 2.6.16.y was staying open for a much 
longer time, as per Adrian's "2.6.16 long living kernel" announcement a 
short while back.

I just assumed that the Greg and Chris were handling it until 2.6.18 
gets released, and then Adrian takes over 2.6.16.y while the [stable] 
team moves on to 2.6.17.y and 2.6.18.y ...  Was this an incorrect 
assumption?

...and if not, should 2.6.16.y patches always be sent to 
stable@kernel.org, or will Adrian have an alternate method for accepting 
patches?

-Mike
