Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbRESKOe>; Sat, 19 May 2001 06:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbRESKOY>; Sat, 19 May 2001 06:14:24 -0400
Received: from james.kalifornia.com ([208.179.59.2]:56158 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S261742AbRESKOI>; Sat, 19 May 2001 06:14:08 -0400
Message-ID: <3B064690.2040803@kalifornia.com>
Date: Sat, 19 May 2001 03:10:24 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518093414.A21164@qcc.sk.ca> <mailman.990252541.15890.linux-kernel2news@redhat.com> <200105190640.f4J6efG11140@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

>>[about Aunt Tullie]
>>Because, for example, a kernel compile can be a part of the standard 
>>install now, and you will end up with a kernel built specifically for 
>>your machine that doesn't print 50 initialization failed messages on boot.
>>[...]
>>And you can also now run a kernel built for your shiny new Athlon, not 
>>the old piece of shit that was hot stuff in '92.
>>
>
>It is way too easy to crush your example, by pointing out that
>Red Hat ships and automatically installs an Athlon-optimized kernel.
>
>However, the argument above is wrong even if Red Hat did not.
>We are talking about CML2 and interaction with Aunt Tullie.
>This has nothing to do with automated rebuild at install time.
>
>-- Pete
>

First off, the lady's name was Tillie ;)

Second, how many kernels does Redhat ship in order to have one for 
386/486/586/k6/Athlon . . . .
Quite a pain in the ass.  And look at how much shit has to be built in 
in order to get a kernel that works for everybody!  People bitch at 
Microsoft for doing it, then turn around and do the same thing.

And nobody said anything about an automated rebuild.

I said a custom kernel build at install time.  I said nothing about 
having it automated.  I wouldn't trust an automated build anyways, 
especially if it came from Redhat.  With the philosophy ESR is aiming 
at, it would be all to easy to ask the user if they'd like to build a 
custom kernel, then present them with Eric's interface.  And that has 
everything to do with interaction with good ole Aunt Tillie.

-b

-- 
 "One trend that bothers me is the glorification of
stupidity, that the media is reassuring people it's 
alright not to know anything. That to me is far more 
dangerous than a little pornography on the Internet." 
  - Carl Sagan



