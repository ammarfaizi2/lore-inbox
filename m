Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRK3Tmv>; Fri, 30 Nov 2001 14:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283719AbRK3Tmc>; Fri, 30 Nov 2001 14:42:32 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:16783 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S283711AbRK3Tm1>; Fri, 30 Nov 2001 14:42:27 -0500
To: jgarzik@mandrakesoft.com, pgallen@randomlogic.com
Subject: Re: Coding style - a non-issue
Cc: kplug-list@kernel-panic.org, kplug-lpsg@kernel-panic.org,
        linux-kernel@vger.kernel.org
Message-Id: <E169tj8-00055G-00@DervishD.viadomus.com>
Date: Fri, 30 Nov 2001 20:53:38 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jeff and Paul :)

>"Paul G. Allen" wrote:
>> IMEO, there is but one source as reference for coding style: A book by
>> the name of "Code Complete". (Sorry, I can't remember the author and I
>> no longer have a copy. Maybe my Brother will chime in here and fill in
>> the blanks since he still has his copy.)
>Hungarian notation???
>That was developed by programmers with apparently no skill to
>see/remember how a variable is defined.  IMHO in the Linux community
>it's widely considered one of the worst coding styles possible.

    Not at all... Hungarian notation is not so bad, except it is only
understood by people from hungary. So the name }:))) I just use it
when I write code for Hungary or secret code that no one should
read...

>>  - Short variable/function names that someone thinks is descriptive but
>> really isn't.
>not all variable names need their purpose obvious to complete newbies. 
>sometimes it takes time to understand the code's purpose, in which case
>the variable names become incredibly descriptive.

    Here you are right. The code can be seen really as a book: you
can start reading at the middle and yet understand some of the story,
but it's far better when you start at the beginning ;))) Moreover,
most of the variable and function names in the kernel code are quite
descriptive, IMHO.

    Of course, more comments and more descriptive names doesn't harm,
but some times they bloat the code...

    Raúl
