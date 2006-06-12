Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751951AbWFLNZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWFLNZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 09:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWFLNZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 09:25:42 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:47633 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751951AbWFLNZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 09:25:41 -0400
Message-ID: <448D6B53.3070803@onelan.co.uk>
Date: Mon, 12 Jun 2006 14:25:39 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6 Section mismatch warnings
References: <4488057A.9090301@onelan.co.uk> <20060608195902.26902ef0.rdunlap@xenotime.net>
In-Reply-To: <20060608195902.26902ef0.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Thu, 08 Jun 2006 12:09:46 +0100 Barry Scott wrote:
>
>   
>> When I built 2.6.17-rc6 I see a lot of warnings after the MODPOST message
>> about Section mismatch. What did I do wrong in building the kernel and 
>> modules?
>>     
> ...
>   
>> Here are some of the warnings:
>>     
>
> It would be helpful if someone could look at/work on the
> section mismatches in the isdn and sound drivers...
>
> I have 6 new patches to post, then I'll be
> sweeping the net drivers soon.
>   
The alsa folks have fixed their problem and you should see a patch from them
shortly.

Any news on the net driver problems?

Barry


