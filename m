Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282443AbRKZT4m>; Mon, 26 Nov 2001 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282459AbRKZT4a>; Mon, 26 Nov 2001 14:56:30 -0500
Received: from james.kalifornia.com ([208.179.59.2]:58176 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S282463AbRKZT4F>; Mon, 26 Nov 2001 14:56:05 -0500
Message-ID: <3C029E59.4040106@blue-labs.org>
Date: Mon, 26 Nov 2001 14:56:09 -0500
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011125
X-Accept-Language: en-us
MIME-Version: 1.0
To: sinisa@mysql.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15 and GNU 3.0.2
In-Reply-To: <15362.34918.524256.760222@sinisa.nasamreza.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That really depends on what sort of system you are running it on.

Out of five computers I build kernels for at home here, one of them has 
an AMD K6II processor in it and that is the only one that I need to use 
gcc 2.95.3 with.  The rest I use 3.0.x and they are quite stable.  I 
just did a round of updates to 2.5.1p, but their prior uptimes were 
between 30 and 80 days.

I'm not saying 3.0.2 is perfect, for sure it isn't.  I'm saying that in 
some situations it can certainly be used.

Every compiler has issues, for some projects I have to use 3.0.2, some I 
have to use 2.95.3.  You keep notes on what works best and go with it.

David

Sinisa Milivojevic wrote:

>Hi!
>
>I think that documentation should stress more strongly that GNU 3.0.*
>series of compilers can not be used for building of the production
>kernels.
>
>I have got kernel panic in init ....
>
>This is not a complaint, just an information.
>
>


