Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVGKBND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVGKBND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGKBND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:13:03 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1239 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261200AbVGKBNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:13:01 -0400
Message-ID: <42D1C797.40305@namesys.com>
Date: Sun, 10 Jul 2005 18:12:55 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Ed Cogburn <edcogburn@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl> <200507100848.05090.tomlins@cam.org>
In-Reply-To: <200507100848.05090.tomlins@cam.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:

>On Sunday 10 July 2005 01:10, Horst von Brand wrote:
>  
>
>>Ed Cogburn <edcogburn@hotpop.com> wrote:
>>    
>>
>>>David Lang wrote:
>>>      
>>>
>>>>On Fri, 8 Jul 2005, Ed Tomlinson wrote:
>>>>        
>>>>
>>>>>No Flame from me.  One thing to remember is that Hans and friends
>>>>>_have_ supported R3 for years.
>>>>>          
>>>>>
>>They let it fall into disrepair when they started work on 4.
>>    
>>
>
>This is FUD.  Hans do you have figures on how many fixes for R3 have
>been added in the last year or so?
>  
>
No, but I can tell you that > 2/3 were related to features I thought
should have been put in V4 instead, and were added in violation of my
declared code freeze and without my consent.  Naturally, those bugs were
routed to the authors of those features.

There were maybe 2 bugs in the last 18 months in code not related to
code freeze violations, I don't remember exactly.

There is a simple reason why Namesys no longer spends much time on bug
fixes for V3.  The frozen code is too stable to generate bug reports to
work on, and the unfrozen code is not ours.  If the unfrozen code
stopped being maintained, I'd have to do something.

It seems to me that you should all hope that V4 gets to where Namesys
does not spend much time maintaining it.  It means we have no bug reports.

Stable branches, and development branches, and only bug fixes get added
to the stable branch, it is an old paradigm, and broadly speaking it is
still the right paradigm.

Guys, Horst is trolling.    He has never used our code, and yet.....

