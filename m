Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbUKTPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUKTPGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbUKTPGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:06:04 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:42150 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262969AbUKTPF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:05:56 -0500
Message-ID: <419F5D69.2080407@verizon.net>
Date: Sat, 20 Nov 2004 10:06:17 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove obsolete Computone MAINTAINERS entry (fwd)
References: <20041120002559.GB2754@stusta.de> <20041119194735.63d2a257.akpm@osdl.org> <20041120125017.GB2829@stusta.de>
In-Reply-To: <20041120125017.GB2829@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.220.243] at Sat, 20 Nov 2004 09:05:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Nov 19, 2004 at 07:47:35PM -0800, Andrew Morton wrote:
> 
>>Adrian Bunk <bunk@stusta.de> wrote:
>>
>>>I'm not sure whether it makes sense to list the previous maintainers for 
>>> orphaned code, but if such entries contain buouncing mail addresses it's 
>>> IMHO time to simply remove them.
>>>
>>>...
>>> -M:	Michael H. Warfield <mhw@wittsend.com>
>>
>>wittsend.com is still there and Michael still runs it.
> 
> 
> At least the listed mailing list is defunct:
> 
> <linux-computone@lazuli.wittsend.com>:
> Sorry, I wasn't able to establish an SMTP connection. (#4.4.1)
> I'm not going to try again; this message has been in the queue too long.
> 
> 
> And to be honest, I don't see that much value in shiping entries in 
> MAINTAINERS for people who have reseigned as maintainers.
> 
> 
> cu
> Adrian
> 

If someone is willing to step up to the plate and get the driver working again, it 
would be better to have the contact information for the old maintainer available 
in a centralized location.  Plus, anyone who tries the driver and finds it busted 
can look in the MAINTAINERS file and find out that it's not being fixed, instead 
of it being one of those drivers that has no defined maintainer (I've run across a 
few).

After all, we do have to be honest about unmaintained drivers - rather than hiding 
broken code.  Honestly, it's better to define who's responsible for an area of 
code, even if it no longer works.

My $0.02.

Jim
