Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316963AbSFQUAP>; Mon, 17 Jun 2002 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSFQUAO>; Mon, 17 Jun 2002 16:00:14 -0400
Received: from www.transvirtual.com ([206.14.214.140]:13060 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316963AbSFQUAN>; Mon, 17 Jun 2002 16:00:13 -0400
Date: Mon, 17 Jun 2002 12:59:14 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@suse.cz>
cc: Ingo Molnar <mingo@elte.hu>, Keith Owens <kaos@ocs.com.au>,
       Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>,
       <linux-kernel@vger.kernel.org>, xsdg <xsdg@openprojects.net>
Subject: Re: [patch] early printk. (was: Re: computer reboots before
 "Uncompressing Linux..." with 2.5.19-xfs)
In-Reply-To: <20020612172754.C87@toy.ucw.cz>
Message-ID: <Pine.LNX.4.44.0206171258470.31825-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > >>Then, after a small pause, the box reboots (note: it does _not_ print
> > > >>"Uncompressing Linux...").  I have tried the following:
> > > >
> > > >Interesting problem.....  Interesting because I'm having the EXACT
> > > >SAME PROBLEM!!!!  ARRRRRGGGGHHH!!!!
> > >
> > > Try http://marc.theaimsgroup.com/?l=linux-kernel&m=101072840225142&w=2
> >
> > you might as well try the attached early_printk() patch, it's slightly
> > easier to use than a one-char macro. But the goal is the same.
>
> Could this be arch-independend? x86-64 has it, too, and AFAIR it was taken
> from ia64.. Plus, it is *very* usefull.

Please be patient. The new console code will support earlier printking.

