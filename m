Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135858AbREIFhX>; Wed, 9 May 2001 01:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbREIFhE>; Wed, 9 May 2001 01:37:04 -0400
Received: from anime.net ([63.172.78.150]:23313 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S135589AbREIFgy>;
	Wed, 9 May 2001 01:36:54 -0400
Date: Tue, 8 May 2001 22:36:08 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Larry McVoy <lm@bitmover.com>
cc: Marty Leisner <leisner@rochester.rr.com>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <20010508222210.B14758@work.bitmover.com>
Message-ID: <Pine.LNX.4.30.0105082233430.30695-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Larry McVoy wrote:
> which is a text version of the paper I mentioned before.  The basic
> message of the paper is that it really doesn't help much to have things
> like ECC unless you can be sure that 100% of the rest of your system
> has similar checks.

UDMA has crc, scsi has parity, pci has (i think) parity, tcpip has crc,
your cpu l1 and l2 have ecc...

Looks like similar checks are already there.

-Dan

