Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTLBSUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLBSUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:20:52 -0500
Received: from [63.81.117.28] ([63.81.117.28]:15898 "HELO cyber1hq.adic.com")
	by vger.kernel.org with SMTP id S262766AbTLBSUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:20:30 -0500
Message-ID: <3FCCD7B6.8060503@adic.com>
Date: Tue, 02 Dec 2003 12:19:34 -0600
From: Steve Lord <lord@adic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031121 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Larry McVoy <lm@work.bitmover.com>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@adic.com> <20031202180251.GB17045@work.bitmover.com> <20031202181146.A27567@infradead.org>
In-Reply-To: <20031202181146.A27567@adic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Dec 02, 2003 at 10:02:51AM -0800, Larry McVoy wrote:
>  
>
>>Not your call, it's Marcelo's call.  And I and he have both suggested
>>that the way to get XFS in is to have someone with some clout in the file
>>system area agree that it is fine.  It's a perfectly reasonable request
>>and the longer it goes unanswered the less likely it is that XFS will get
>>integrated.  The fact that $XFS_USER wants it in is $XFS_USER's problem.
>>$VFS_MAINTAINER needs to say "hey, this looks good, what's the fuss about?"
>>and I suspect that Marcelo would be more interested.
>>    
>>
>
>I think you're missing the point.  The patches have been review many
>times, they've been posted to lkml many time with the request for comment
>and they've been merged into 2.5 in almost exactly that form. 
>
>  
>
>>It is also not unreasonable to reject a set of changes right before
>>freezing 2.4.  2.4 is supposed to be dead.
>>    
>>
>
>That's indeed a point and a very resonable one.  But a few of the patches
>Nathan has in that BK repo have been submited for more than year again
>and again, and Marcelo's reply (for those 10% of the cases that a reply
>existed at all) was something along the lines "let's postpone it after
>the next release".  In my opinion that's not the right attitude from
>a kernel maintainer to someone who wants to contribute major work.
>
>  
>
Thank you Christoph,

Been sitting here reading this and attempting to control my blood pressure.
One thing those folks out there saying this code needs reviewing might
want to consider is that XFS spent several months getting 'Christophed'
in the last year. Those of you who have seen Christoph in action know what
that means ;-).

Steve

