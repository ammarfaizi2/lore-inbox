Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278194AbRJLW70>; Fri, 12 Oct 2001 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278195AbRJLW7Q>; Fri, 12 Oct 2001 18:59:16 -0400
Received: from jalon.able.es ([212.97.163.2]:2948 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278194AbRJLW7J>;
	Fri, 12 Oct 2001 18:59:09 -0400
Date: Sat, 13 Oct 2001 00:59:30 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: J Sloan <jjs@lexus.com>
Cc: "T . A ." <tkhoadfdsaf@hotmail.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: Which kernel (Linus or ac)?
Message-ID: <20011013005930.I1693@werewolf.able.es>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <3BC5EB56.21B4EF88@bigfoot.com> <3BC5FA12.F8E5C91E@lexus.com> <OE64cxtniFKULPEhGD100007fff@hotmail.com> <3BC688A2.4C7640B7@pobox.com> <OE394qrvAsp4XgWZGbR0000e29d@hotmail.com> <3BC729E2.E93A416E@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BC729E2.E93A416E@lexus.com>; from jjs@lexus.com on Fri, Oct 12, 2001 at 19:35:30 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011012 J Sloan wrote:
>After this post we should take it offline and
>let the s/n ratio on lkml settle back down to
>a dull roar - apologies for the noise, this is
>the last post on this dead horse.
>
>"T. A." wrote:
>
>
>Here is a heads-up for the benefit of those wondering
>about gcc-2.96:
>
>http://www.bero.org/gcc296.html
>

Nice, a bunch of comments about the front end. But you miss the point
that what was broken in gcc-2.96 was the back end (the optimizer). 
And you missed that it needed about 50 updates to get a real compiler.
gcc that ships with RH 7.1 generates bad code in optimized mode. Do not
remember the exact post in LKML, but I saw 2 lines of code that made gcc
put the user initialization of a variable before the automatic one to zero.

If you want a good distro, take Mandrake 8.1.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-pre1-beo #1 SMP Fri Oct 12 11:32:03 CEST 2001 i686
