Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271640AbRIGJYW>; Fri, 7 Sep 2001 05:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271641AbRIGJYM>; Fri, 7 Sep 2001 05:24:12 -0400
Received: from tangens.hometree.net ([212.34.181.34]:18329 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271640AbRIGJYC>; Fri, 7 Sep 2001 05:24:02 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Date: Fri, 7 Sep 2001 09:24:21 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9na3o5$c9$1@forge.intermeta.de>
In-Reply-To: <20010906204104.A3FBDBC06C@spike.porcupine.org> <Pine.GSO.4.30.0109061643030.14727-100000@shell.cyberus.ca> <20010906232033.L13547@emma1.emma.line.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 999854661 26691 212.34.181.4 (7 Sep 2001 09:24:21 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 7 Sep 2001 09:24:21 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

>See it from the user-space programmer's point of view. Imagine you're
>developing your software on FreeBSD or Solaris, or whatever. Now imagine
>a client/user asks you about Linux support. You figure Linux does an

So you actually say "make it the way BSD does, because that's what we
know and support". Sheesh. Why don't you just use Netlink and start
preaching to the BSD and Solaris folks that "this is the way how it
should be done". I'd say there are more Linux machines than BSD and
Solaris combined out there.

With this attitude, why don't you program WIN32? It's even more
widespread.

And Mr. Veenema has the guts to talk about "superiority complex"? Please.

If you want to write Software for Platform "L", use the APIs of
platform "L", not the legacy compatibility layer that "L" has to
support some old "B" applications. With this attitude you will be
stuck with "B" applications for the next twenty years. Or until "B"
decides to change its API when you will come running to the "A"
authors to demand that they must now change their legacy API to
support "B+".

	Regards
		Henning

P.S.: My personal conclusion: I go with sendmail ;-)


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
