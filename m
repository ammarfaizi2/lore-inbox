Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRDJV4U>; Tue, 10 Apr 2001 17:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDJV4K>; Tue, 10 Apr 2001 17:56:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131631AbRDJVzy>; Tue, 10 Apr 2001 17:55:54 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 10 Apr 2001 22:57:09 +0100 (BST)
Cc: dhowells@cambridge.redhat.com (David Howells),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 10, 2001 12:42:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n68O-0005IF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's no problem if we make this SMP-specific - I doubt anybody actually
> uses SMP on i486's even if the machines exist, as I think they all had

They do. There are two (total world wide) 486 SMP users I know about and they
mostly do it to be awkward ;)

> special glue logic that Linux would have trouble with anyway. But the

The Compaqs were custom, the non Compaq ones included several using Intel
MP 1.1.

Alan

