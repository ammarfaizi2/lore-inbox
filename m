Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132132AbQLJAlC>; Sat, 9 Dec 2000 19:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132452AbQLJAkx>; Sat, 9 Dec 2000 19:40:53 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:19214 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S132132AbQLJAkr>; Sat, 9 Dec 2000 19:40:47 -0500
Date: Sat, 9 Dec 2000 16:10:13 -0800
From: Richard Henderson <rth@twiddle.net>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
Message-ID: <20001209161013.A30555@twiddle.net>
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 09:43:00AM +0100, Abramo Bagnara wrote:
> alpha-mb-2.4.diff add missing defines from core_t2.h for non generic
> kernel (against 2.4.0test11)

These are not "missing".  They are intentionally not present
so that stuff will be done out of line.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
