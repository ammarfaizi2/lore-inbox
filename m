Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRA2WrC>; Mon, 29 Jan 2001 17:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRA2Wqw>; Mon, 29 Jan 2001 17:46:52 -0500
Received: from clueserver.org ([206.163.47.224]:33555 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S131199AbRA2Wqp>;
	Mon, 29 Jan 2001 17:46:45 -0500
Date: Mon, 29 Jan 2001 14:57:44 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Recommended swap for 2.4.x.
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the recommended amount of swap with the 2.4.x kernels?

The standard rule is usually memory x 2.  (But that is more a Solaris
superstition than anything else.)

Is it the same or "as much as I can get away with" or something else?

I am asking because I have just ordered a new drive for my Vaio (8.1 gig
in a 8.45mm drive!) and I want to install 2.4.x on it.  (I like getting
the swap partition done right the first time. Repartitions are a pain.
Especially if you screw up.)

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
