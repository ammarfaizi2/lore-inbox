Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQVgf>; Fri, 17 Nov 2000 16:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKQVgQ>; Fri, 17 Nov 2000 16:36:16 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:21776 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129097AbQKQVgI>;
	Fri, 17 Nov 2000 16:36:08 -0500
Date: Fri, 17 Nov 2000 13:07:03 -0800
From: David Hinds <dhinds@valinux.com>
To: barryn@pobox.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4's internal PCMCIA works for me (was Re: [PATCH] pcmcia event thread)
Message-ID: <20001117130703.C8211@valinux.com>
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> <200011172030.MAA01854@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <200011172030.MAA01854@cx518206-b.irvn1.occa.home.com>; from Barry K. Nathan on Fri, Nov 17, 2000 at 12:30:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 12:30:38PM -0800, Barry K. Nathan wrote:
> 
> I do understand that the in-kernel support isn't as mature as the external
> support yet. However, it isn't universally broken and useless either.

That's certainly true; it should work fine for the large majority of
configurations.  I think the non-platform-specific issues are mostly
resolved.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
