Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132136AbQLJTPK>; Sun, 10 Dec 2000 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132401AbQLJTPA>; Sun, 10 Dec 2000 14:15:00 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:55311 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S132136AbQLJTOr>; Sun, 10 Dec 2000 14:14:47 -0500
Date: Sun, 10 Dec 2000 10:44:13 -0800
From: Richard Henderson <rth@twiddle.net>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
Message-ID: <20001210104413.A31257@twiddle.net>
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A334F7C.3205A3DF@alsa-project.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 10:40:12AM +0100, Abramo Bagnara wrote:
> And this would be the only core_*.h files where this intention is
> expressed?

Not at all.  See core_lca.h, jensen.h, core_cia.h, core_mcpcia.h.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
