Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRASBoY>; Thu, 18 Jan 2001 20:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRASBoE>; Thu, 18 Jan 2001 20:44:04 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48134 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136710AbRASBlK>; Thu, 18 Jan 2001 20:41:10 -0500
Date: Thu, 18 Jan 2001 21:51:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
In-Reply-To: <20010119011629.C32087@athlon.random>
Message-ID: <Pine.LNX.4.21.0101182119120.4610-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Andrea Arcangeli wrote:

> Marcelo can you give a try with `high_queued_sectors = total_ram / 3' and
> low_queued_sectors = high_queued_sectors / 2 and drop the big ram machine
> check?

Andrea,

With the changes you suggested I got almost the same results with
pre8. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
