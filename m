Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFTUkj>; Thu, 20 Jun 2002 16:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSFTUki>; Thu, 20 Jun 2002 16:40:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56592 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315451AbSFTUkh> convert rfc822-to-8bit; Thu, 20 Jun 2002 16:40:37 -0400
Message-ID: <3D123DB9.8090909@evision-ventures.com>
Date: Thu, 20 Jun 2002 22:40:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020620103003.C6243@host110.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Cort Dougan napisa³:
> "Beating the SMP horse to death" does make sense for 2 processor SMP
> machines.  When 64 processor machines become commodity (Linux is a
> commodity hardware OS) something will have to be done.  When research

64 processor machines will *never* become a commodity becouse:

1. It's not like paralell machines are something entierly new. They are
around for an awfoul long time on this planet. (nearly longer then myself)

2. See 1. even dual CPU machines are a rarity even *now*.

3. Nobody needs them for the usual tasks they are a *waste*
of resources and economics still applies.

4. SMP doesn't scale behind 4. Point. (64 hardly makes sense...)

5. It will never become a commodity to run highly transactional
workloads where integrated bunches of 4 make sense. Neiter will
it be common to solve partial differential equations for aeroplane
dynamics or to calculate the behaviour of an hydrogen bomb.

6. Even in the aerodynamics department an only 14 CPU machine was
very very fast.  (NEC SX-3R)

7. Hyper threaded cores make hardly sense behind 2.

8. Amdahls law is math and not a decret from the Central Komitee of
the Kommunist Party or George Bush. You can not overrule it.

One exception could be dedicated rendering CPUs - which is the
direction where graphics cards are apparently heading - but they
will hardly ever need a general purpose operating system. But even then -
I'm still in the bunch of people who are not interrested
in any OpenGL or Direct whatever... The worsest graphics cards
those days drive my display screens at the resolutions I wish them too
just fine.

PS. I'm sick of seeing bunches of PC's which are accidentally in
the same room nowadays in the list of the 500 fastest computers
on the world. It makes this list useless...

If one want's to have a grasp on how the next generation of
really fast computers will look alike. Well: they will be based
on Johnson-junctions. TRW will build them (same company
as Voyager sonde). Look there they don't plan for thousands of CPUs
they plan for few CPUs in liquid helium:

http://www.trw.com/extlink/1,,,00.html?ExternalTRW=/images/imaps_2000_paper.pdf&DIR=2


