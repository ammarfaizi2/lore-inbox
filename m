Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRL1Wms>; Fri, 28 Dec 2001 17:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRL1Wmi>; Fri, 28 Dec 2001 17:42:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45835 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S284180AbRL1Wmc>; Fri, 28 Dec 2001 17:42:32 -0500
Message-ID: <3C2CF2A8.9010406@evision-ventures.com>
Date: Fri, 28 Dec 2001 23:31:04 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Keith Owens <kaos@ocs.com.au>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
In-Reply-To: <20011227173739.U25698@work.bitmover.com> <18754.1009503708@ocs3.intra.ocs.com.au> <20011227174723.V25698@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Fri, Dec 28, 2001 at 12:41:48PM +1100, Keith Owens wrote:
>
>>On Thu, 27 Dec 2001 17:37:39 -0800, 
>>Larry McVoy <lm@bitmover.com> wrote:
>>
>>>A couple of questions:
>>>
>>>a) will 2.5 be as fast as the current system?  Faster?
>>>
>>At the moment kbuild 2.5 ranges from 10% faster on small builds to 100%
>>slower on a full kernel build.  
>>
>
>I don't understand why it would be slower. 
>
Thank's go to basically to python and other excessfull overengineering 
there.


