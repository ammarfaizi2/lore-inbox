Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275351AbTHMTXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275353AbTHMTXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:23:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2301 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S275351AbTHMTWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:22:36 -0400
Message-ID: <3F355F12.4040609@mvista.com>
Date: Sat, 09 Aug 2003 13:52:34 -0700
From: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
CC: rob@landley.net, Daniel Phillips <phillips@arcor.de>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308061728.04447.rob@landley.net> <200308071642.55517.phillips@arcor.de> <200308071651.07522.rob@landley.net> <3F32C752.4000403@wmich.edu>
In-Reply-To: <3F32C752.4000403@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> >>
> 
> the problem is you want a process that works like it was run on a single 
> tasking OS on an operating system that is built from the ground up to be 
>  a multi-user multi-tasking OS and you want both to work perfectly at 
> peak performance and you want it to know when you want which to work at 
> peak performance automatically.

Well said :)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

