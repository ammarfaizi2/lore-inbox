Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRCFTFN>; Tue, 6 Mar 2001 14:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRCFTEy>; Tue, 6 Mar 2001 14:04:54 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:28401 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129249AbRCFTEr>;
	Tue, 6 Mar 2001 14:04:47 -0500
Message-ID: <3AA518C0.A0194586@fc.hp.com>
Date: Tue, 06 Mar 2001 12:05:04 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alessandro Baretta <alex@baretta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inadequate documentation: sockets
In-Reply-To: <E14aMHj-0001E1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > =46inally I'm left with my original problem: how am I supposed to
> > detect a close or a shutdown from the peer? Once again, I thank in
> > advance anyone who will lend me a hand by explaining this to me or
> > by addressing me to more adequate documentation.
> 
> By an EOF on read or getting SIGPIPE/EPIPE on a write. You might want to pick
> up a book on the subject of network programming. There are some very nice ones
> around

As Alan already pointed out, a book on network programming can answer
these questions. I would recommend "UNIX Network Programming, Volume 1:
Networking APIs - Sockets and XTI" by W. Richard Stevens.

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
