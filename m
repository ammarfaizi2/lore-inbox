Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQKTLqc>; Mon, 20 Nov 2000 06:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129308AbQKTLqN>; Mon, 20 Nov 2000 06:46:13 -0500
Received: from chiara.elte.hu ([157.181.150.200]:29457 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129183AbQKTLpw>;
	Mon, 20 Nov 2000 06:45:52 -0500
Date: Mon, 20 Nov 2000 13:25:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Jasper Spaans <jasper@spaans.ds9a.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: [PATCH] Re: What is 2.4.0-test10: md1 has overlapping physical
 units with md2!
In-Reply-To: <14872.29951.707116.16506@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0011201325190.1005-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2000, Neil Brown wrote:

>  the attached patch, modifies a warning message in md.c which seems to
>  often cause confusion - the following email includes one example
>  there-of (there have been others over the months).
> 
>  Hopefully the new text is clearer.

yep, agreed - thanks!

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
