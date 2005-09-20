Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVITIAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVITIAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVITIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:00:06 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61351 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964923AbVITIAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:00:01 -0400
Message-ID: <432FC181.8000304@namesys.com>
Date: Tue, 20 Sep 2005 01:00:01 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509192303.j8JN3ieA030649@inti.inf.utfsm.cl>
In-Reply-To: <200509192303.j8JN3ieA030649@inti.inf.utfsm.cl>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> Care to give names?

Not publicly, no.  If akpm or Linus asks, I will happily encourage
either of them to try to win him back.

>  
>
>>                                             who decided to work on BSD
>>because they had too much dignity to develop a filesystem for  Linux.
>>    
>>
>
>Their loss, I presume...
>
everyone's loss, it is a negative sum game.

> and you clearly think the same way, because if it
>weren't you wouldn't be around here trying to push ReiserFS into Linux, and
>would be bothering one of the BSDs instead.
>  
>
I committed to Linux way back when it was obscure compared to BSD..... 
and I like the way the GPL allows me to make some small amount of money
selling licenses in addition to the GPL, and the way MS can't reuse my
code for free without attribution.

>
>  
>
>>V3 is obsoleted by V4 in every way.  V3 is old code that should be
>>marked as deprecated as soon as V4 has passed mass testing.   V4 is far
>>superior in its coding style also.  Having V3 in and V4 out is at this
>>point just stupid. 
>>    
>>
>
>V3 /is/ being used by many people. Just decreeing it has to be pulled out
>"because V4 is better" is just irresponsible. And that is exactly the
>attitude I don't like.
>  
>
I didn't say V3 should be pulled out, I said marked as deprecated.   And
left alone so that it gets only bug fixes and not new features.

>  
>
>>This whole thing reminds me of an IBMer who told me that he thought that
>>IBM lost to MS because they called OS/2 by a name other than DOS.  The
>>sad thing is he was probably right. 
>>    
>>
>
>The IBMer was dead wrong, OS/2 was strangled by lack of applications.
>  
>
Uh, no, it ran all the DOS applications better than DOS did.  Seriously,
it did.  I remember DOS applications that were easier to make work under
OS/2 due to 640k something or another.  I pray the memory of exactly
what does not return to me.;-)

>  
>
>>V4, as it is today, is as much superior to V3 as OS/2 was to DOS.  Any
>>distro or user who would stay with V3 for new installs once we have
>>passed mass testing is nuts.  We need the mass testing.
>>    
>>
>
>And people who have existing setups don't count?
>
Of course they count.  I don't expect any users to convert from V3 to V4
on an existing OS installation until we have a robustly working
convertfs, and even then most of them won't.  Please note the phrase
"new installs", it was very intentional.

> Cautious people who won't
>touch a new filesystem with a ten foot pole until it has got mass testing
>in a mainstream distribution for a couple of years are irrelevant?
>  
>
I fully expect that there will be people using V3 long past the time
when better filesystems are available and working and stable, the world
has a lot of lag time to it.;-)

