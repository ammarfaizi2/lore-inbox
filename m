Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbQLKWbo>; Mon, 11 Dec 2000 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130658AbQLKWbX>; Mon, 11 Dec 2000 17:31:23 -0500
Received: from innerfire.net ([208.181.73.33]:55047 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S130902AbQLKWbP>;
	Mon, 11 Dec 2000 17:31:15 -0500
Date: Mon, 11 Dec 2000 14:03:46 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        John Fremlin <vii@penguinpowered.com>, scole@lanl.gov,
        linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <E145Xy6-0008HA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012111357430.21909-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Alan Cox wrote:

> > Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
> > for the VM doesn't make any sense since it doesn't really excercise
> > the VM in any way...
> 
> Its an interesting demo that 2.4 has some performance problems since 2.2
> is slower than 2.0 although nowdays not much.

How much of that is due to the fact that the 2.4.0 scheduler interrupts
processes more often than 2.2.x?  Is the better interactivity worth the
slight drop in performance?

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
