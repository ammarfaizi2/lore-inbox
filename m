Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTKPWyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTKPWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:54:46 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:41422 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263002AbTKPWyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:54:44 -0500
X-Sender-Authentication: net64
Date: Sun, 16 Nov 2003 23:54:42 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
Message-Id: <20031116235442.5cbcfec0.skraw@ithnet.com>
In-Reply-To: <200311161838.hAGIciLa030513@turing-police.cc.vt.edu>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031116130558.GB199@elf.ucw.cz>
	<20031116184012.5d9f4c12.skraw@ithnet.com>
	<200311161838.hAGIciLa030513@turing-police.cc.vt.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 13:38:44 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Sun, 16 Nov 2003 18:40:12 +0100, Stephan von Krawczynski said:
> 
> > There is quite a simple difference in -XX kernel and a distro-patch. People
> > have to actively decide to use some patched kernel for whatever their
> > reason may be. A distro on the other hand floods the average user with
> > patched versions _without_ the users' active decision.
> 
> Take it the other direction - people *also* actively choose a distro based
> on some reason (to be honest, a major reason I ended up in RedHat/Fedora
> rather than some other Linux distro or even a *bsd was because at the time
> I needed a *nix with an X server that supported the i810 chipset, they were
> the only ones shipping one pre-built).

Well, this is a good point to explain that some people choose their favourite
distro based on completely other criteria one might expect. I choose mine
because it was a european company and I found it acceptable to make a
"political decision" rather than a pure technical one. In a market that is as
imbalanced as IT towards US companies it sounded like the right thing to do for
me.
Unfortunately US companies have this special capability of reducing your choice
as a customer right down to (almost) zero - which is of course their simple
right in a free market environment.
And this is about the point where the debian project enters my picture ...
 
> On the flip side, I freely admit that the vast majority of things Andrew
> puts in his kernel basically get flooded to me, because installing the
> entire -mm patch is a lot easier than installing half of it....

Which is about my argument placed on a higher level of user experience ;-)

Regards,
Stephan

