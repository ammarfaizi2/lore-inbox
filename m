Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSE2USe>; Wed, 29 May 2002 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315462AbSE2USd>; Wed, 29 May 2002 16:18:33 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:25617 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315459AbSE2USb>; Wed, 29 May 2002 16:18:31 -0400
Message-ID: <3CF5377C.777FB41D@linux-m68k.org>
Date: Wed, 29 May 2002 22:18:04 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: yodaiken@fsmlabs.com, linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
In-Reply-To: <Pine.LNX.4.21.0205291440420.17583-100000@serv> <1022684357.4123.219.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> > 1. We are talking about a free software project here!
> > 2. They asked a lawyer, here is the result:
> >    http://lwn.net/2002/0131/a/rtai-24.1.8.php3
> 
> So why is he still moaning. He's got a legal opinion that he can use
> binary apps on RTAI without paying the license. What else does he want ?

That Victor acknowledges that this is correct legal advice and he will
accept that?
Instead we see statements like this: "it would still not be permitted to
link binary modules into the derived program without our permission. 
RTAI "user space"  to me, does not escape this issue."
How will he do this? To our knowledge applications don't infringe the
patent and he can't change the kernel license. What does he know that we
don't know?

Let me quote from Victor's FAQ:
"If you want to mix GPL and non-GPL software under unmodified Open
RTLinux, you may be able to do so as well, but we suggest caution. The
intent of our license and the GPL itself is to permit reciprocal sharing
of software technology. If you have software that you prefer not to make
available to others, then you may be able to take advantage of the
"unmodified Open RTLinux" provisions of our license or you may need to
use RTLinux/Pro."
In other word: if you want to be safe, use the license or buy our
product. Other options are not mentioned. What has the user to be
cautioned of, when he mixes the GPL with the LGPL? In my understanding
these are subtle, but clear threats against unauthorized use of the
patent.
It's nice that he wants to help the GPL, but we should refuse such help.
I would do quite a lot to promote the GPL, but I would never force
people to use the GPL. It's very important that people do this out of
their free will and Victor doesn't offer much choice here. A patent is a
very dangerous tool, it gives you an exclusive right, which must not be
abused.

bye, Roman
