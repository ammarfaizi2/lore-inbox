Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283249AbRLDSWD>; Tue, 4 Dec 2001 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281645AbRLDSU0>; Tue, 4 Dec 2001 13:20:26 -0500
Received: from maile.telia.com ([194.22.190.16]:53223 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S283259AbRLDSTx>;
	Tue, 4 Dec 2001 13:19:53 -0500
Message-Id: <200112041818.fB4IIua03097@d1o849.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jakob Kemi <jakob.kemi@telia.com>
To: =?iso-8859-1?q?Ra=FAlN=FA=F1ez=20de=20Arenas=20Coronado?= 
	<raul@viadomus.com>,
        linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Tue, 4 Dec 2001 19:17:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: esr@thyrsus.com, hch@caldera.de, kaos@ocs.com.au,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesdayen den 4 December 2001 18.08, RaúlNúñez de Arenas	 Coronado wrote:
>     Hi Matthias :)
>
> >Creating a dependency on Python? Is a non-issue.
>
>     Maybe for you. For me it *is* an issue. I don't like more and
> more dependencies for the kernel. I mean, if I can drop kbuild and
> keep on building the kernel with the old good 'make config' I won't
> worry, but otherwise I don't think that kernel building depends on
> something like Python.
>
>     Why must I install Python in order to compile the kernel? I don't
> understand this. I think there are better alternatives, but kbuild
> seems to be imposed any way.
>
> >You don't make the pen yourself when writing a letter either.
>
>     I don't like to be forced in a particular pen, that's the reason
> why I use and develop for linux.
>
> >What are the precise issues with Python? Just claiming it is an
> >issue is not useful for discussing this. Archive pointers are
> >welcome.
>
>     Well, let's start writing kernel drivers with Python, Perl, PHP,
> awk, etc... And, why not, C++, Ada, Modula, etc...
>
>     The kernel should depend just on the compiler and assembler, IMHO.

And you'll select and pass every .c file directly to the compiler via the 
command line ?? Sounds like a giant step forwards !!

