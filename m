Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130332AbQJ0UzX>; Fri, 27 Oct 2000 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbQJ0UzM>; Fri, 27 Oct 2000 16:55:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130332AbQJ0UzG>; Fri, 27 Oct 2000 16:55:06 -0400
Subject: Re: Somewhat different GPL Question
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 27 Oct 2000 21:49:44 +0100 (BST)
Cc: cfriesen@nortelnetworks.com (Christopher Friesen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0010271604360.25174-100000@duckman.distro.conectiva> from "Rik van Riel" at Oct 27, 2000 04:06:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pGRe-0004pR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're making interprocess calls to call the GPL code,
> I suspect you won't have to make your code GPL.
> 
> OTOH, if you /link/ against a GPL shared library, you will
> have to GPL the source of your program (that is, you'll have
> to give it to the people who receive the binary from you).

The out of court settlements don't actually bear up to this interpretation
and have been more about 'depending on' as a definition for linking and what
is and is not an entire application.

Its one reason Im glad Linus had the sense to put an explicit statement about
syscalls in the kernel COPYING file.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
