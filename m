Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbTAIQjz>; Thu, 9 Jan 2003 11:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTAIQjz>; Thu, 9 Jan 2003 11:39:55 -0500
Received: from [63.162.183.250] ([63.162.183.250]:34625 "EHLO
	emgw2ksrv001.emgdom001.emageon.com") by vger.kernel.org with ESMTP
	id <S266837AbTAIQjy>; Thu, 9 Jan 2003 11:39:54 -0500
Message-ID: <3E1DA7DB.4060604@emageon.com>
Date: Thu, 09 Jan 2003 10:48:27 -0600
From: Brian Tinsley <btinsley@emageon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Russell Coker <russell@coker.com.au>, ReiserFS <reiserfs-list@namesys.com>,
       Rik van Riel <riel@nl.linux.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd CPU usage and heavy disk IO
References: <200301091431.54451.russell@coker.com.au> <3E1D9D10.40700@emageon.com> <200301091742.51101.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Jan 2003 16:48:30.0750 (UTC) FILETIME=[F0B0F3E0:01C2B7FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

>I think you should have cc'ed Andrea Arcangeli <andrea@suse.de>, LKM and try 
>2.4.20-aa1.
>
I've got the -aa1 patch, but I have not been able to build the Linux 
Virtual Server code with it yet. I absolutely depend on this and have a 
request for assistance posted to that mailing list.

>Are you sure it is a ReiserFS and not a kernel thing?
>
I don't believe it's a reiserfs issue. That's just where this thread 
started. IMHO, it's a kernel issue.

>  
>
-- 

-[========================]-
-[      Brian Tinsley     ]-
-[ Chief Systems Engineer ]-
-[        Emageon         ]-
-[========================]-




