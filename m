Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSG3Bpf>; Mon, 29 Jul 2002 21:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSG3Bpf>; Mon, 29 Jul 2002 21:45:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12812 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318182AbSG3Bpf>; Mon, 29 Jul 2002 21:45:35 -0400
Date: Mon, 29 Jul 2002 22:48:53 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spinlock.h cleanup
Message-ID: <20020730014853.GC12290@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
References: <1027989053.929.263.camel@sinai> <Pine.LNX.4.44.0207291845470.945-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207291845470.945-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 29, 2002 at 06:46:40PM -0700, Linus Torvalds escreveu:
> On 29 Jul 2002, Robert Love wrote:
> > If I recall correctly, the fix was for older egcs compilers.
> 
> I've got this memory of fairly recent gcc's messing up on sparc, for
> example.

And IIRC the current supported compiled for Sparc32 is an old hacked egcs.

- Arnaldo
