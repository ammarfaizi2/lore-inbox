Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSL2Prk>; Sun, 29 Dec 2002 10:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSL2Prk>; Sun, 29 Dec 2002 10:47:40 -0500
Received: from web13204.mail.yahoo.com ([216.136.174.189]:54279 "HELO
	web13204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266417AbSL2Pri>; Sun, 29 Dec 2002 10:47:38 -0500
Message-ID: <20021229155600.95805.qmail@web13204.mail.yahoo.com>
Date: Sun, 29 Dec 2002 07:56:00 -0800 (PST)
From: Anomalous Force <anomalous_force@yahoo.com>
Subject: Re: holy grail
To: Rik van Riel <riel@conectiva.com.br>
Cc: Werner Almesberger <wa@almesberger.net>, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.50L.0212281842020.26879-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Rik van Riel <riel@conectiva.com.br> wrote:
> On Sat, 28 Dec 2002, Anomalous Force wrote:
> > --- Werner Almesberger <wa@almesberger.net> wrote:
> >
> > > because it would be completely unmaintainable (1,2). (I expect
> to
> >
> > this is not true. if the system were an integral part of the
> overall
> > design, then programming would include it apriori.
> 
> This has been said before, but "for some reason" everybody
> who said it went quiet the moment they started working on
> a patch and have never been heard from again.
> 
> Either they're still working on the problem (after a four
> years) or they've moved on to an easier/realistic project.

i have stated this would be extremely difficult. no single person
could attempt this without the support of the other developers as
the effort must include all aspects of the kernel to some extent.
the original discussion for this was to show that kexec() _could_
become something that is a holy grail amoung kernel developers:
hot-swap. if all of the kernel developers think this can not be done,
then it is not worth discussion any further. for a single person to
make this happen, it would require that a single kernel version
become frozen, and all aspects of it altered to support the
operations of hot swapping. in such a senario, the development of
the mainstream kernel would have progressed to the point that
any attempting to apply a patch would prove futile as the code base
for the patch has become obsolete. it is for this reason that i say
it would take the awareness of all the developers moving forward.

> 
> regards,
> 
> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
> http://www.surriel.com/		http://guru.conectiva.com/
> Current spamtrap:  <a
href=mailto:"october@surriel.com">october@surriel.com</a>


=====
Main Entry: anom·a·lous 
1 : inconsistent with or deviating from what is usual, normal, or expected: IRREGULAR, UNUSUAL
2 (a) : of uncertain nature or classification (b) : marked by incongruity or contradiction : PARADOXICAL
synonym see IRREGULAR

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
