Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265891AbRGGDVK>; Fri, 6 Jul 2001 23:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265970AbRGGDVA>; Fri, 6 Jul 2001 23:21:00 -0400
Received: from dsl-64-192-146-25.telocity.com ([64.192.146.25]:4873 "EHLO
	dsl-64-192-146-25.telocity.com") by vger.kernel.org with ESMTP
	id <S265891AbRGGDUx>; Fri, 6 Jul 2001 23:20:53 -0400
Message-ID: <3B467FF6.A2D991E7@telocity.com>
Date: Fri, 06 Jul 2001 22:20:22 -0500
From: Greg Rollins <gregrollins@telocity.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Kacur <jkacur@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver doesn't work as module on 2.4.6
In-Reply-To: <3B4677EB.966BA972@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kacur wrote:

> Hi
>
> With Kernel 2.4.6, when I compile the Tulip driver as a module, I don't
> have network connectivity. I can ping myself, and netstat -rn gives the
> same table as with earlier kernels, but I can't connect to any of the
> other computers on my network. (network = 1 pentium 120, and 1 pentium
> 133 running a 2.2.16 and a 2.0.36 kernel respectively.) (the module is
> loaded correctly and I have all the correct levels of support programs
> as listed in the Changes file.) When I compile the Tulip driver directly
> into the Kernel, it works.
>
> I would be happy to provide more information to anybody who wants to try
> to figure this one out, just ask me what you need to know.
>
> Thanks
>
> John Kacur
>
> jkacur@home.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I haven't had this problem.  I did my compile last p.m. and so far my Compaq
Deskpro is running better than ever.  Which tulip based card are you
running?  Mine is a Linksys 10/100.  More detail please.  I'm doing a modular
load also.

Greg Rollins
gregrollins@telocity.com

