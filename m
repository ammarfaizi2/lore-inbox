Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130044AbQKAAJ7>; Tue, 31 Oct 2000 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbQKAAJt>; Tue, 31 Oct 2000 19:09:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47736 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130044AbQKAAJp>; Tue, 31 Oct 2000 19:09:45 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: mhw@wittsend.com (Michael H. Warfield)
Date: Wed, 1 Nov 2000 00:07:50 +0000 (GMT)
Cc: jmerkey@timpanogas.org (Jeff V. Merkey), npsimons@fsmlabs.com,
        lm@bitmover.com (Larry McVoy), pmenage@ensim.com (Paul Menage),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <20001031190034.B24279@alcove.wittsend.com> from "Michael H. Warfield" at Oct 31, 2000 07:00:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qlRY-0008S3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> users must be fairly recent (4.x and about - 3.x has come into discussion
> but doesn't count here) customers.  Obviously, they are big and SIGNIFICANT
> customers.  Do we know that Linux can't handle the load, though, or is
> this just more supposition based on statistics?

On the same hardware netware 3 at least tended to beat us flat, but then it
wasnt a general purpose OS. I think what Jeff is trying to build is basically
a box that runs netware in the netware 3/4 style - ie fast and a little 
unprotected with a standard linux application space protected mode on top of it
- its an interesting concept.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
