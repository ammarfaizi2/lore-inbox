Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285630AbSAHK45>; Tue, 8 Jan 2002 05:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286239AbSAHK4r>; Tue, 8 Jan 2002 05:56:47 -0500
Received: from Expansa.sns.it ([192.167.206.189]:11539 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S285630AbSAHK4b>;
	Tue, 8 Jan 2002 05:56:31 -0500
Date: Tue, 8 Jan 2002 11:55:59 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0201081153310.29480-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote (passim):

> Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or
> -rmap?
[...]
> Maybe preemption? It is disengageable so nobody should be harmed but we get
> the chance for wider testing.
>
> Any comments?
preemption?? this is eventually 2.5 stuff, and should not be integrated
into 2.4 stable tree. Of course a backport is possible, when/if it will be
quite well tested and well working on 2.5





