Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRLKPrY>; Tue, 11 Dec 2001 10:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280402AbRLKPrP>; Tue, 11 Dec 2001 10:47:15 -0500
Received: from Expansa.sns.it ([192.167.206.189]:43790 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S280365AbRLKPrF>;
	Tue, 11 Dec 2001 10:47:05 -0500
Date: Tue, 11 Dec 2001 16:46:41 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <20011211014346.C4801@athlon.random>
Message-ID: <Pine.LNX.4.33.0112111644440.11161-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Dec 2001, Andrea Arcangeli wrote:

> On Mon, Dec 10, 2001 at 05:08:44PM -0200, Marcelo Tosatti wrote:
> >
> > Andrea,
> >
> > Could you please start looking at any 2.4 VM issues which show up ?
>
> well, as far I can tell no VM bug should be present in my latest -aa, so
> I think I'm finished. At the very least I know people is using 2.4.15aa1
> and 2.4.17pre1aa1 in production on multigigabyte boxes under heavy VM
> load and I didn't got any bugreport back yet.
2.4.17pre1aa1 is quire rock solid on all my 2 and 4 GB machines
But I have to admitt that actually I did not really stressed the VM on my
servers, since, guys, we are going to christmass :)



