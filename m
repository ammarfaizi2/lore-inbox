Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUFROzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUFROzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFROze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:55:34 -0400
Received: from mail.dif.dk ([193.138.115.101]:52205 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265201AbUFROzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:55:32 -0400
Date: Fri, 18 Jun 2004 16:54:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Kyle McMartin <kyle@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <Pine.LNX.4.56.0406181647340.16649@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.56.0406181652530.16649@jjulnx.backbone.dif.dk>
References: <40D232AD.4020708@opensound.com> <20040618002017.GA29005@engsoc.org>
 <Pine.LNX.4.56.0406181647340.16649@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jesper Juhl wrote:

> On Thu, 17 Jun 2004, Kyle McMartin wrote:
>
> > On Thu, Jun 17, 2004 at 05:09:17PM -0700, 4Front Technologies wrote:
> > > Files linux-2.6.5/arch/i386/boot98/setup.S and
> > > linux-2.6.5-7.75/arch/i386/boot98/setup.S differ
> > >
> > Ok. They edit setup.S. This doesn't change APIs.
> >
> > > Files linux-2.6.5/arch/i386/defconfig and
> > > linux-2.6.5-7.75/arch/i386/defconfig differ
> > >
> > SuSE doesn't ship the default kernel .config. *SHOCK!* Neither does
> > anyone else.
> >
> Well, Slackware Linux usually ships with an unmodified kernel.org kernel
> (there are rare cases of patches that fix security issues though). I find
> this a very nice property of Slackware since there are never any problems
> when replacing the default kernel with a custom build kernel.org one...
> There are other minor distributions that also ship with kernel.org
> kernels - I don't have a list at hand, but I've run into several over the
> years.
>
Whoops, should have read the parent email better. Slackware does not use
the default kernel .config, it does however use the kernel.org source
without additional patches.. I agree, nobody ships a defconfig kernel.


--
Jesper Juhl <juhl-lkml@dif.dk>

