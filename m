Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTKPPzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKPPzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:55:23 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:61856 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262914AbTKPPzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:55:21 -0500
Message-ID: <3FB6F542.5000309@namesys.com>
Date: Sat, 15 Nov 2003 19:55:46 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Mike Fedyk <mfedyk@matchmail.com>, herbert@gondor.apana.org.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031104210310.GA1068@matchmail.com> <20031105004956.19dbd3fb.skraw@ithnet.com> <20031116130558.GB199@elf.ucw.cz>
In-Reply-To: <20031116130558.GB199@elf.ucw.cz>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>There was a bug in one of the released Debian kernels, and do you think this
>>>hasn't happened with Redhat, SuSe, or Mandrake?  Just because Debian is
>>>completely OSS and maintained mostly by unpaid volunteers, that shouldn't
>>>keep them from having a seperate tree like everyone else.
>>>      
>>>
>>Just to avoid a false impression: I am in no way against debian project nor do
>>I say there is anything specifically bad about it. I am generally disliking
>>distros' ideas of having _own_ kernels. Commercial companies like SuSE or Red
>>Hat may find arguments for that which are commercially backed, debian on the
>>other hand can hardly argue commercially. From the community point of view it
>>is just nonsense. It means more work and less useable feedback.
>>Bugs is distro kernels are (always) the sole fault of their respective
>>maintainers because they actively decided _not_ to follow the mainstream and
>>made bogus patches. Why waste the appreciated work of (unpaid) debian
>>volunteers in this area? There are tons of other work left with far more
>>relevance for users than bleeding edge kernel patches...
>>    
>>
>
>
>Debian is distibution; distributions are _expected_ to fix bugs (etc)
>in their packages.
>  
>
not in their packages, but in their packaging, and to submit bug fixes 
to the maintainers.


>If distribution had all packages unmodified, it would be useless...
>  
>
not at all.

>So I'd expect all distros to have at least some changes in their
>kernel... the same way I expect distros to have some patches in
>midnight commander etc.
>
>Of course it is good to keep the .diff as small as possible.
>								Pavel
>  
>
I just want to say that I would happily do 10 times as much work to keep 
things working for debian, but not using the vanilla kernel is a mistake 
for debian, just as changing, say, xmms without involving the xmms 
maintainer would be a mistake and more likely to cause bugs for users.  
Just because SuSE and RedHat have lots of money doesn't mean that debian 
should ape their mistakes.

-- 
Hans


