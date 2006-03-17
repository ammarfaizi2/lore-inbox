Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWCQNvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWCQNvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWCQNvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:51:38 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:40336 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932688AbWCQNvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:51:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jFdP2smVes5PzgcFCEydAMc5Sy4t5RayX8Xd+W+8RuNGvg396fKpVm8sytm9I7XpzkVANAiIjA+C/FPS7vKNGssHKcx1Ebnezt/JfcUllGzR2VMzWqGI8T2WGpUvdSDfEOcUYAGOdV5etICJggKPiQV1GbXvynSlQXfRwW6L/cQ=  ;
Message-ID: <441ABEE5.3050408@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:51:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
References: <200603081013.44678.kernel@kolivas.org> <200603172338.10107.kernel@kolivas.org> <441AB8FA.10609@yahoo.com.au> <200603180036.11326.kernel@kolivas.org> <441ABD9F.6060407@yahoo.com.au>
In-Reply-To: <441ABD9F.6060407@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Con Kolivas wrote:

>> I'm not attached to the style, just the feature. If you think it's 
>> warranted I'll change it.
>>
> 

> At least other archtectures might be able to make better use of it,
> and I agree even for i386 the code looks better (and slightly smaller).
> 

s/I agree/I think/

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
