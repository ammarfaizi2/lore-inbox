Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314329AbSEIUnL>; Thu, 9 May 2002 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314338AbSEIUnK>; Thu, 9 May 2002 16:43:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17413 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314329AbSEIUnJ>; Thu, 9 May 2002 16:43:09 -0400
Message-ID: <3CDAD08D.2090102@evision-ventures.com>
Date: Thu, 09 May 2002 21:39:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: akpm@zip.com.au, indigoid@higherplane.net, dank@kegel.com,
        khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
In-Reply-To: <20020509114009.GD3855@higherplane.net>	<20020509.042938.78984470.davem@redhat.com>	<3CDACE73.6692A31E@zip.com.au> <20020509.123540.85382726.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik David S. Miller napisa?:
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Thu, 09 May 2002 12:30:59 -0700
> 
>    The concern with moving one (major) application into the
>    kernel is that this will weaken the testing/motivation to get
>    zerocopy, aio and sophisticated notifications working well
>    for userspace.
>    
> Actually, to the contrary, TUX was in fact an impetus for the
> userlevel zerocopy and AIO bits :-)
> 
> I personally don't see anything wrong with something like the
> TUX engine being in there.  At the same time I want to reiterate what
> Ingo said which is what we can do in userspace catches up to what
> TUX can do then we pull it out and move on to the next thing :-)

It's far easiet to add then to remove. Trust me ;-).

I vote against both of them: tux and khttpd are should have
no place in the kernel of a General Pupose OS kernel.

