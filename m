Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAHXuA>; Mon, 8 Jan 2001 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAHXtk>; Mon, 8 Jan 2001 18:49:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48392 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129387AbRAHXtf>; Mon, 8 Jan 2001 18:49:35 -0500
Subject: Re: The advantage of modules?
To: root@chaos.analogic.com
Date: Mon, 8 Jan 2001 23:49:16 +0000 (GMT)
Cc: goemon@anime.net (Dan Hollis), rmk@arm.linux.org.uk (Russell King),
        meissner@spectacle-pond.org (Michael Meissner), ookhoi@dds.nl (Ookhoi),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010108174358.6769A-100000@chaos.analogic.com> from "Richard B. Johnson" at Jan 08, 2001 06:06:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fm2Q-0005dO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Although I haven't been involved for over 8 years, it us unlikely that
> the word "SCSI" has been given up as some generic aspirin. SCSI still
> means the stuff specified in the 519 Page document copyrighted by
> ANSI, called "SMALL COMPUTER SYSTEM INTERFACE - 2", Dated May 20, 1991,
> and the first draft released in June of 1986.

SCSI nowdays is a message protocol. Its what powers fibrechannel at the high
end and ATAPI (IDE) and USB at the low end.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
