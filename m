Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbREZB3Z>; Fri, 25 May 2001 21:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbREZB3P>; Fri, 25 May 2001 21:29:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262483AbREZB27>; Fri, 25 May 2001 21:28:59 -0400
Date: Fri, 25 May 2001 18:28:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.31.0105251731090.1105-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0105251826290.1126-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I applied Andrea's (nee Ingo's) version, as that one most clearly
attacked the real deadlock cause. It's there as 2.4.5 now.

I'm going to be gone in Japan for the next week (leaving tomorrow
morning), so please don't send me patches - I won't be able to react to
them anyway. Consider the -ac series and the kernel mailing list the
regular communications channels..

Thanks,

		Linus

