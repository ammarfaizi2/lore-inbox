Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRLDRA1>; Tue, 4 Dec 2001 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLDQ66>; Tue, 4 Dec 2001 11:58:58 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:36233 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S281283AbRLDQ6V>; Tue, 4 Dec 2001 11:58:21 -0500
To: linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Cc: esr@thyrsus.com, hch@caldera.de, kaos@ocs.com.au,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Message-Id: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
Date: Tue, 4 Dec 2001 18:08:57 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Matthias :)

>Creating a dependency on Python? Is a non-issue.

    Maybe for you. For me it *is* an issue. I don't like more and
more dependencies for the kernel. I mean, if I can drop kbuild and
keep on building the kernel with the old good 'make config' I won't
worry, but otherwise I don't think that kernel building depends on
something like Python.

    Why must I install Python in order to compile the kernel? I don't
understand this. I think there are better alternatives, but kbuild
seems to be imposed any way.

>You don't make the pen yourself when writing a letter either.

    I don't like to be forced in a particular pen, that's the reason
why I use and develop for linux.

>What are the precise issues with Python? Just claiming it is an
>issue is not useful for discussing this. Archive pointers are
>welcome.

    Well, let's start writing kernel drivers with Python, Perl, PHP,
awk, etc... And, why not, C++, Ada, Modula, etc...

    The kernel should depend just on the compiler and assembler, IMHO.

    Raúl
