Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269345AbRHFX7Q>; Mon, 6 Aug 2001 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHFX7G>; Mon, 6 Aug 2001 19:59:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44552 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269345AbRHFX6u>; Mon, 6 Aug 2001 19:58:50 -0400
Subject: Re: [PATCH] one of $BIGNUM devfs races
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 7 Aug 2001 00:59:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 06, 2001 05:55:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TuHf-00022E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, fair enough. When is your next merge with Linus scheduled? I'd
> prefer to get a few races fixed before shipping a patch, but I can try
> to plan for an earlier release if necessary.

I send stuff Linus regularly and sometimes it goes in and sometimes it
doesn't. Stuff with active maintainers I don't send on to Linus unless asked
too - hence joystick. input and much of USB are so far behind in Linus tree
