Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312271AbSCYCg1>; Sun, 24 Mar 2002 21:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312270AbSCYCgS>; Sun, 24 Mar 2002 21:36:18 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:44710 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S312268AbSCYCgL>; Sun, 24 Mar 2002 21:36:11 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: David Flynn <dave@woaf.net>
Subject: Re: Possible problems with D-LINK DFE-550TX (stock sundance driver) under 2.4.18
Date: Mon, 25 Mar 2002 03:36:07 +0100
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203250336.08428.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002 02:08:33, Matthias Andree wrote:
>On Mon, 25 Mar 2002, David Flynn wrote:
> > With the following hardware::
> >   dual Athlon XP 1700+
> >   D-Link DFE-550TX NIC
> >   SiS cheapo g/card
>
> El cheapo configuration, Athlon XP are not stable in SMP configurations.
>
> (I look after a dual XP 1700+ machine with Tyan board, and it falls over
> from time to time, but booted with just one CPU, the machine is rock
> solid.)
>
> Try booting with just one processor (maxcpus=1 boot option) or borrow
> two Athlon MP and see if you can reproduce the problem then. If you can,
> someone may help you. I you can't reproduce it with one CPU, you're
> probably on your own.

On "newer" Athlon XP (Duron, Athlon Thoroughbred) L5-4 bridge have to be 
closed.

See below: 

http://www.hardwarezone.com/articles/articles.hwz?cid=2&aid=393&page=1
http://www.hardwarezone.com/articles/articles.hwz?cid=2&aid=395

Regards,
	Dieter

BTW I will use two Athlon XP 1700+ or...;-)

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

