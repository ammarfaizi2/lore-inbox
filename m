Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVDEKW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDEKW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVDEKTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:19:18 -0400
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:16064 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S261692AbVDEKQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:16:58 -0400
Message-ID: <425265EE.6010303@pin.if.uz.zgora.pl>
Date: Tue, 05 Apr 2005 12:18:22 +0200
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Natanael Copa <mlists@tanael.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
References: <424AE48C.8000805@pin.if.uz.zgora.pl>	 <1112263230.1165.15.camel@nc>  <1112289106.1829.10.camel@mindpipe> <1112694429.32468.27.camel@nc>
In-Reply-To: <1112694429.32468.27.camel@nc>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natanael Copa napisa³(a):
> On Thu, 2005-03-31 at 12:11 -0500, Lee Revell wrote:
> 
> 
>>Didn't you ever look up what a ulimit is?
> 
> 
> ofcourse i did. I just think that ulimit (or other userspace tools)
> should be used to *raise* the limit if you need more. Not the reverse.
> 
> 
>>If you consider your distro's default ulimits unreasonable, file a bug
>>report with them.  But no one is going to make Linux "restrictive by
>>default" to make life easier for people who don't bother to RTFM.
> 
> 
> I already suggested ulimit solutions for my distro. They think that if
> this is needed the kernel dev's would do something (ie its a kernel
> problem) while the kernel dev's says this is a userspace prob.
> 
> I wouldn't bother if this was a problem for one or two distros only.
> Now, almost all distros seems to be vulnerable by default.
> 
> I wouldn't bother if other *nixes would set this limit in userspace.
> (the BSD's set the limit lower in kernel and let users who need more
> raise with userland tools)
> 
> I wouldn't bother if this wouldn't give Linux a bad reputation.
> 
> I'm Sorry if I made some people upset.
> 
> --
> Natanael Copa
> 
> 
You have absolutely right!!! Even if 'good' ulimit is set there isn't
anything bad in adding ulimit-like mechanism into kernel.

Long live ... hmm... kernel, not ulimit:)

Best regards,
Jacek

