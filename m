Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUEQQa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUEQQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUEQQa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:30:26 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:7184 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261879AbUEQQaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:30:20 -0400
Message-ID: <40A8E8A1.2090404@hp.com>
Date: Mon, 17 May 2004 12:30:25 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517161432.GG6763@smtp.west.cox.net>
In-Reply-To: <20040517161432.GG6763@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>On Sun, May 16, 2004 at 02:55:14AM -0700, Andrew Morton wrote:
>
>  
>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm3/
>>
>>- A few VM changes, getting things synced up better with Andrea's work.
>>
>>- A new kgdb stub, for ia64 (what happened to the grand unified kgdb
>>  project?)
>>    
>>
>
>No one asked the ia64 folks who did that work "Hey, have you looked at
>the grand unified kgdb project on kgdb.sf.net ?" would be my guess.
>
>Having said that, if you're willing to go with a slightly late
>initalizing (I saw part of the early_param work get dropped again I
>think, so I'm gonna guess you don't wanna deal with that again yet) KGDB
>for i386 and PPC32, I can whip something up vs 2.6.6 in a day or so.
>  
>

I did the ia64 port and started with Andrew's 2.6.4-mm2 i386 sources.  
I'm assuming the long term strategy is to move to a unified kgdb being 
done on sourceforge?  If so, I'll take a look at this.

thanks

Bob

