Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUJMFMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUJMFMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJMFMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:12:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:63133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268177AbUJMFMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:12:44 -0400
Message-ID: <416CB85A.7030309@osdl.org>
Date: Tue, 12 Oct 2004 22:08:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       Con Kolivas <kernel@kolivas.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       ankitjain1580@yahoo.com, Ingo Molnar <mingo@elte.hu>, rml@tech9.net
Subject: Re: Difference in priority
References: <1097542651.2666.7860.camel@cube>	 <cone.1097626558.804486.12364.502@pc.kolivas.org>	 <1097630263.2674.9508.camel@cube> <1097643510.1553.120.camel@krustophenia.net>
In-Reply-To: <1097643510.1553.120.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-10-12 at 21:17, Albert Cahalan wrote:
> 
>>I can't see why the RT priority range would be increased.
>>It's overkill already, especially since Linux doesn't have
>>priority inheritance. Since POSIX requires 32 levels, that
>>is the right number. Actually using more than one level
>>(remember: NO priority inheritance) might not be wise.
> 
> 
> Linux will probably have priority inheritance soon.  See the "Real Time
> Kernel" thread.

Is that opinion based any on this article and Linus's comments in it?

http://news.com.com/A+new+direction+for+Linux+for+gadgets/2100-7344_3-5406291.html?tag=cd.top


-- 
~Randy
