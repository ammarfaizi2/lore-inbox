Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314143AbSEBAQv>; Wed, 1 May 2002 20:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSEBAQu>; Wed, 1 May 2002 20:16:50 -0400
Received: from jalon.able.es ([212.97.163.2]:6339 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314143AbSEBAQt>;
	Wed, 1 May 2002 20:16:49 -0400
Date: Thu, 2 May 2002 02:16:43 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] intel eths for 2.4 [was: Plan for e100-e1000 in mainline]
Message-ID: <20020502001643.GE1698@werewolf.able.es>
In-Reply-To: <20020501010828.GA1753@werewolf.able.es> <3CCF796C.5090401@mandrakesoft.com> <20020501234644.GA1698@werewolf.able.es> <3CD0827B.1050902@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.02 Jeff Garzik wrote:
>J.A. Magallon wrote:
>
>>On 2002.05.01 Jeff Garzik wrote:
>>
>>>I expect Intel's Q/A to green light their current driver.  With a few 
>>>patches it should be ready for 2.4.x soon.
>>>
>
>>I did it, taking drivers from 2.5.12, and at least it compiles.
>>I have to try in the real box, but I don't think there were any problems,
>>at least the same than 2.5....
>>
>>Marcelo, is there any chance to get this in next -pre or in .19 ?
>>
>
>When they are suitable for Marcelo, I'm going to send them to Marcelo.
>
>As I wrote in the quoted message, they need some more patches, and I'm 
>also interested in feedback from Intel Q/A (which is scheduled for 
>sometime this week).
>

Oops, sorry, I misunderstood something.

>If you are interesting in maintaining 2.4.x patches for a short time, go 
>for it.  But I would rather not have a almost-ready e100 go to Marcelo 
>and get released in 2.4.19 in incomplete form.  It's out there, it's 
>public, let's leave at that for a little while.
>

OK, just forget all about -pre and .19.

If somebody wants to try them, look at one other post about -jam9.
It is the same story, I need them for some new boxen (e1000) and I prefer
to have all in the same tree than apart, so took those from 2.5
instead of Intel's.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
