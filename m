Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRIUC3o>; Thu, 20 Sep 2001 22:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274603AbRIUC3f>; Thu, 20 Sep 2001 22:29:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38921 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272265AbRIUC3W>; Thu, 20 Sep 2001 22:29:22 -0400
Date: Thu, 20 Sep 2001 23:29:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Xymoron <oxymoron@waste.org>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Stefan Westerfeld <stefan@space.twc.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <200109210214.f8L2E8R27561@mailg.telia.com>
Message-ID: <Pine.LNX.4.33L.0109202328200.1548-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Roger Larsson wrote:

> > > The yield we do in __alloc_pages is it really correct?

> > > I have to try...
>
> Unexpected result, but interesting.
> Things got MUCH WORSE!

Not at all unexpected, this thing has been tested
extensively in the 2.4.0-test* kernels.

Is it really so hard to learn from the past if it's
more than 6 weeks ago ?

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

