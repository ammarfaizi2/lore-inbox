Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRJ3RXX>; Tue, 30 Oct 2001 12:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276489AbRJ3RXN>; Tue, 30 Oct 2001 12:23:13 -0500
Received: from denise.shiny.it ([194.20.232.1]:50611 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S275693AbRJ3RXJ>;
	Tue, 30 Oct 2001 12:23:09 -0500
Message-ID: <XFMail.20011030182326.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011030175417.K1340@athlon.random>
Date: Tue, 30 Oct 2001 18:23:26 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: please revert bogus patch to vmscan.c
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> #ifdef ?
>
> yes, but not for ppc, for alpha and all other archs without accessed bit
> provided in hardware (and cached in the tlb).

PPCs have that bits. I'm not sure if they are cached in the tbl.


Bye.

