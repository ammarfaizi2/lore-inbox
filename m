Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130705AbRBGBCw>; Tue, 6 Feb 2001 20:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130811AbRBGBCn>; Tue, 6 Feb 2001 20:02:43 -0500
Received: from chiara.elte.hu ([157.181.150.200]:5643 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130705AbRBGBCc>;
	Tue, 6 Feb 2001 20:02:32 -0500
Date: Wed, 7 Feb 2001 02:01:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206185115.A23754@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.30.0102070157560.14418-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Jeff V. Merkey wrote:

> I remember Linus asking to try this variable buffer head chaining
> thing 512-1024-512 kind of stuff several months back, and mixing them
> to see what would happen -- result. About half the drivers break with
> it. [...]

time to fix them then - instead of rewriting the rest of the kernel ;-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
