Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268322AbTBYU1q>; Tue, 25 Feb 2003 15:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268298AbTBYU0P>; Tue, 25 Feb 2003 15:26:15 -0500
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:50359 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S268322AbTBYUZt>; Tue, 25 Feb 2003 15:25:49 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Steven Cole" <elenstev@mesatop.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Hans Reiser" <reiser@namesys.com>, "LKML" <linux-kernel@vger.kernel.org>,
       "Larry McVoy" <lm@bitmover.com>
Subject: RE: Minutes from Feb 21 LSE Call
Date: Tue, 25 Feb 2003 15:37:34 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJIEPCEPAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1046149973.2544.186.camel@spc1.mesatop.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> Hans may have 32 CPUs in his $3000 box, and I expect to have 8 CPUs in
> my $500 Walmart special 5 or 6 years hence.  And multiple chip on die
> along with HT is what will make it possible.

Or will Walmart be selling systems with one CPU for $62.50?

"Normal" folk simply have no use for an 8 CPU system. Sure, the technology
is great -- but no many people are buying HDTV, let alone a computer system
that could do real-time 3D holographic imaging. What Walmart is selling
today for $199 is a 1.1 GHz Duron system with minimal memory and a 10GB hard
drive. Not exactly state of the art (although it might make a nice node in a
super-cheap cluster!)

Of course, you'll have your Joe Normals who will buy multiprocessor machines
with neon lights and case windows -- but those are the same people who drive
a Ford Excessive 4WD SuperCab pickup when the only thing they ever "haul" is
groceries.

(Note: I drive a big SUV because I *do* haul stuff, and I've got lots of
kids -- the right tool for the job, as Alan stated.)

> What concerns me is that this will make it possible to put insane
> numbers of CPUs in those $250,000 and higher boxes.  If Martin et al can
> scale Linux to 64 CPUs, can they make it scale several binary orders of
> magnitude higher? Why do this?  NUMA memory is much faster than even
> very fast network connections any day.
>
> Is there a market for such a thing?

Such systems will be very useful in limited markets. If I need to simulate
the global climate or the evolution of galaxies, I can damned-well use
65,536 quad-core CPUs, and I'll be happy to install Linux on such a box.
Writing e-mail or scanning my kids' drawings doesn't require that sort of
power.

> Please listen to Larry.  When he says you can't scale endlessly, I have
> a feeling he knows what he's talking about.  The Nirvana machine has 48
> SGI boxes with 128 CPUs in each.  I don't hear about many 128 CPU
> machines nowadays.  Perhaps Irix just wasn't quite up to the job.  But
> new technologies will make this kind of machine affordable (by the
> government and financial institutions) in the not too distant future.

Linux needs a roadmap; perhaps it has one, and I just haven't seen it?

I'm not entirely certain that Linux can scale from toasters to Deep Thought;
the needs of an office worker don't coincide well with the needs of a
scientist trying to simulate the dynamics of hurricanes. I've worked both
ends of that spectrum; they really are two different universes that may not
be effectively addressed by one Linux.

I, for one, would rather see Linux work best on high-end systems; I have no
problem leaving the low end of the spectrum to consumer-oriented companies
like Microsoft. Linux has the most potential of any extant OS, in my
opinion, for handling the types of systems you envision. And to achieve such
a goal, some planning needs to be done *now* to avoid quagmires and
minefields in the future.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

