Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSGXR6J>; Wed, 24 Jul 2002 13:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSGXR6J>; Wed, 24 Jul 2002 13:58:09 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:59778 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S317457AbSGXR6I>;
	Wed, 24 Jul 2002 13:58:08 -0400
Message-ID: <3D3EED72.1080809@zianet.com>
Date: Wed, 24 Jul 2002 12:09:54 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@wildopensource.com>
CC: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 3com 3c996b-t support?
References: <Pine.LNX.4.33.0207241314550.30282-100000@coffee.psychology.mcmaster.ca> <3D3EE4B1.3000809@zianet.com> <m3adohja4s.fsf@trained-monkey.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jes Sorensen wrote:

>>>>>>"Steve" == kwijibo  <kwijibo@zianet.com> writes:
>>>>>>            
>>>>>>
>
>Steve> http://www.cs.uni.edu/~gray/gig-over-copper/
>
>Steve> The 3com drivers are open-source though, which makes me less
>Steve> hesitent.  And the tigon3 drivers lack of documentation kind of
>Steve> irks me.  I would however like to stick with a mainstream
>Steve> kernel driver cause the support is there if it is needed.  I
>Steve> guess I will give both versions a whirl.  From just glancing at
>Steve> the source of both, it seems that both versions support jumbo
>Steve> frames which is really what I am after.
>
>Well did you look at the code? It's the infamous Broadcom bcm5700
>
Just glanced at it.

>driver which is probably the worst driver code we have seen in the
>Linux community for the last 5 years. Sure you can run it, but don't
>come back and complain when you run into trouble. You will be a lot
>better off using the tg3 driver, or better yet, getting a NIC thats
>less buggy.
>  
>
Is the NIC hardware buggy or is it just the bcm5700 drivers?

Well that answers the question I was after, I will use the
tg3 kernel drivers.  I chose this card cause it had good
performance tests on that web page.  The SK9821 beat
all the gigi NICs but it also costs about 4 times as much
as any other.

Steve

