Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290678AbSARLkN>; Fri, 18 Jan 2002 06:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290677AbSARLkD>; Fri, 18 Jan 2002 06:40:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:23819 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290676AbSARLj4>; Fri, 18 Jan 2002 06:39:56 -0500
Message-ID: <3C4808AA.3010805@namesys.com>
Date: Fri, 18 Jan 2002 14:36:10 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jose Luis Domingo Lopez <jdomingo@internautas.org>,
        Guillaume Boissiere <boissiere@mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
In-Reply-To: <E16RN2p-0005VC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Have you heard anything about when Linus intends to code freeze?  In my 
>>planning I am assuming Sept. 30 is way earlier than 2.6 would ship.  I 
>>remember how long 2.4 took, and I simply assume 2.6 will be the same. 
>> At any rate, there is no way we'll be done earlier than September: it 
>>is a deep rewrite.  Code looks so much better than the old code...., but 
>>it is completely new code.
>>
>
>If Linus says september freezes in september and ships for christmas I will
>be most suprised. If he says september freezes the may after and ships the
>december after that I'd count it normal 
>
>Personally I'd really like to see the block I/O stuff straightened out. The
>neccessary VM bits done, device driver updates and a September freeze. I
>think it can be done, and I think the resulting kernel will be way way
>better for people with 1Gb+ of RAM, so much better that its worth making a
>clear release at that point.
>
>Alan
>
>
Let us encourage him to give us some warning, like 60 days of warning. 
 Let us also encourage him to code freeze VM and VFS first not last (I 
think he agrees with this fortunately).  I am not going to say anything 
about when I would like that freeze to hit, except that we won't be 
ready before September/October because I am finally able to take the 
time to do things right in the design and so I will.  If he freezes in 
~September, we'll have an experimental Reiser4 for him.  Or so I fondly 
hope and vaporize.;-)  

What about the zero-copy stuff I keep hearing rumors about?  How ready 
to go is it?  We want ReiserFS to be well-integrated with it if possible.

Hans

