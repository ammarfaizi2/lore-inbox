Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131685AbQLLQNj>; Tue, 12 Dec 2000 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbQLLQN3>; Tue, 12 Dec 2000 11:13:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32007 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131685AbQLLQNX>;
	Tue, 12 Dec 2000 11:13:23 -0500
Date: Tue, 12 Dec 2000 13:36:33 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Swapping-over-nbd deadlock fixed?
In-Reply-To: <3A3642C6.7D50A6AE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0012121336080.2756-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Jeff Garzik wrote:

> I see in the 2.2.18 release notes that a deadlock, related to
> swapping over a network via nbd, was fixed.  Is this bug present
> in 2.4.x-test?

It _should_ be fixed in 2.4 as well.  Then again, I don't know
if there are any other deadlocks left .. ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
