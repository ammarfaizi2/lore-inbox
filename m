Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLJXjS>; Sun, 10 Dec 2000 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129684AbQLJXjJ>; Sun, 10 Dec 2000 18:39:09 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:56108 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129361AbQLJXix>; Sun, 10 Dec 2000 18:38:53 -0500
Date: Mon, 11 Dec 2000 01:15:51 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: clock@atrey.karlin.mff.cuni.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
In-Reply-To: <20001210211445.00733@ghost.btnet.cz>
Message-ID: <Pine.LNX.4.21.0012110115300.26828-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000 clock@ghost.btnet.cz wrote:

> Hi folks
> 
> What should I do, when I run cdda2wav | gogo (riping CD from a ATAPI
> CD thru mp3 encoder) and get a continuous dropping of characters, on a 16550-
> enhanced serial port, without handshake, with full-duplex load of 115200 bps?
> About 1 of 320 bytes is miscommunicated.

Use handshaking



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
