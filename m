Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbREZXDI>; Sat, 26 May 2001 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbREZXBi>; Sat, 26 May 2001 19:01:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262609AbREZXAa>;
	Sat, 26 May 2001 19:00:30 -0400
Date: Sat, 26 May 2001 08:09:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105261120500.30264-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105260806430.3648-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Rik van Riel wrote:
> 
> O, that part is fixed by the patch that Linus threw away
> yesterday ;)

Rik, I threw away the parts of the patch that were bad and obvious
band-aids, and it was hard to tell whether any of your patch was a
"real" fix as opposed to just making more reservations.

And you have not replied to any of the real arguments for fixing the
_real_ bugs. You jst repeat "my patch, my patch, my patch", without even
acknowledging that others are finding the real _underlying_ problems.

Please take a moment to realize that you're not exactly being helpful.

		Linus

