Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129348AbQK3Jrc>; Thu, 30 Nov 2000 04:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129538AbQK3JrX>; Thu, 30 Nov 2000 04:47:23 -0500
Received: from smtp2.free.fr ([212.27.32.6]:5637 "EHLO smtp2.free.fr")
        by vger.kernel.org with ESMTP id <S129348AbQK3JrM>;
        Thu, 30 Nov 2000 04:47:12 -0500
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Subject: Re: Bonding...
Message-ID: <975575796.3a261af501379@imp.free.fr>
Date: Thu, 30 Nov 2000 10:16:37 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0011291619440.22577-100000@asdf.capslock.lan>
In-Reply-To: <Pine.LNX.4.30.0011291619440.22577-100000@asdf.capslock.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When using ethernet bonding, does it divide the load between the
> two based on connection, or packet by packet?

packet by packet, so you can use both links to aggregate your bandwidth. I've
used it at 200 Mbps with success.

Regards
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
