Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHEjj>; Tue, 7 Nov 2000 23:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKHEjT>; Tue, 7 Nov 2000 23:39:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129057AbQKHEjR>; Tue, 7 Nov 2000 23:39:17 -0500
Date: Tue, 7 Nov 2000 20:39:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Gary E. Miller" <gem@rellim.com>
cc: Mike Galbraith <mikeg@wen-online.de>, MOLNAR Ingo <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deadlock fix
In-Reply-To: <Pine.LNX.4.30.0011071633250.16069-100000@catbert.rellim.com>
Message-ID: <Pine.LNX.4.10.10011072038090.15254-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Nov 2000, Gary E. Miller wrote:
> 
> I see this patch did not make it into test11-pre1.  Without it
> raid1 and SMP do not work together.  Please consider for test11-pre2.

You must have a different test11-pre1 than the one I have.

It's already there in -pre1, as far as I can see.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
