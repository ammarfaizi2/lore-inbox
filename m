Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3R7K>; Mon, 30 Oct 2000 12:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbQJ3R7B>; Mon, 30 Oct 2000 12:59:01 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:4362 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129044AbQJ3R6p>; Mon, 30 Oct 2000 12:58:45 -0500
Date: Mon, 30 Oct 2000 17:58:43 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030184109.C21935@athlon.random>
Message-ID: <Pine.LNX.4.21.0010301755210.26279-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Andrea Arcangeli wrote:

> functionality that needs high performance completly in kernel? People
> may need to write high performance network code for custom protocols,
> this way they will end creating kernel modules with system-crashing
> bugs, memory leaks and kernel buffer overflows (chroot+nobody+logging
> won't work anymore). (plus they will get into pain while debugging)

I'm glad _someone_ is connected to reality with regards the security
implications of throwing loads of servers into kernel space.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
