Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbREZADB>; Fri, 25 May 2001 20:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262088AbREZACl>; Fri, 25 May 2001 20:02:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262087AbREZACb>; Fri, 25 May 2001 20:02:31 -0400
Date: Fri, 25 May 2001 17:02:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <E153Qld-0007Df-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0105251700350.15549-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Alan Cox wrote:
>
> But Linus is right I think - VM changes often prove 'interesting'. Test it in
> -ac , gets some figures for real world use then plan further

.. on the other hand, thinking more about this, I'd rather be called
"stupid" than "stodgy".

So I think I'll buy some experimentation. That HIGHMEM change is too ugly
to live, though, I'd really like to hear more about why something that
ugly is necessary.

		Linus

