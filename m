Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVDATPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVDATPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVDATPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:15:18 -0500
Received: from smartmx-05.inode.at ([213.229.60.37]:16016 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S262864AbVDATO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:14:56 -0500
Message-ID: <424D9DAF.2060504@lawatsch.at>
Date: Fri, 01 Apr 2005 21:14:55 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
References: <3NTHD-8ih-1@gated-at.bofh.it> <3O99L-40N-9@gated-at.bofh.it>	 <424CD018.5000005@shaw.ca> <1112376453.16982.14.camel@orca.madrabbit.org>
In-Reply-To: <1112376453.16982.14.camel@orca.madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> On Thu, 2005-03-31 at 22:37 -0600, Robert Hancock wrote:
> 
>>This is getting pretty ridiculous.. I've tried memory timings down to 
>>the slowest possible, ran Memtest86 for 4 passes with no errors, and 
>>it's been stable in Windows for a few months now. Still something is 
>>blowing up in Linux with this test though..
> 
> 
> Have you run the same memset test under windows?
> 
> I've traced a lot of oddball problems down to bad or marginal power
> supplies.

So far I've tried 2 PSUs and 3 different brands of memory.

No differences. And due to a lack of windows I cant really test it.

I'll try a different (not based on nforce 4) motherboard now.


kind regards Philip
