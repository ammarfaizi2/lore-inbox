Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRLKXBU>; Tue, 11 Dec 2001 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284153AbRLKXBJ>; Tue, 11 Dec 2001 18:01:09 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45582 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284141AbRLKXBA>; Tue, 11 Dec 2001 18:01:00 -0500
Date: Tue, 11 Dec 2001 19:44:43 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dan Maas <dmaas@dcine.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <048e01c18294$7a497650$1a01a8c0@allyourbase>
Message-ID: <Pine.LNX.4.21.0112111944330.26533-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Dec 2001, Dan Maas wrote:

> > > Yes, throughtput-only tests will have their numbers degradated with the
> > > change applied on 2.4.16-pre2.
> > > 
> > > The whole thing is just about tradeoffs: Interactivity vs throughtput.
> > > 
> > > I'm not going to destroy interactivity for end users to get beatiful
> > > dbench numbers.
> >
> > Latency is more of an issue for end user machines.
> 
> Time for CONFIG_OPTIMIZE_THROUGHPUT / CONFIG_OPTIMIZE_LATENCY ?

That would be the best thing to do, yes.

