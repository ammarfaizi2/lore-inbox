Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266698AbRGZLEN>; Thu, 26 Jul 2001 07:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbRGZLEE>; Thu, 26 Jul 2001 07:04:04 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:3332 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S266698AbRGZLDx>; Thu, 26 Jul 2001 07:03:53 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Thu, 26 Jul 2001 13:03:54 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 cyclades-Y crash
Message-ID: <20010726130354.A1024@informatics.muni.cz>
In-Reply-To: <20010724190103.J1033@informatics.muni.cz> <E15P5oK-0000Vs-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15P5oK-0000Vs-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 24, 2001 at 06:17:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
: > connected to 16-port box). The 2.4.7 kernel crashes when initializing the
: > cyclades driver (either as a module or a built-in driver). I've tried
: > the stock kernel from Red Hat 7.1, and the cyclades.o module causes the
: > system to lock up when loaded.
: 
: Is this an SMP box ?

	No. Pentium 233 MMX, 32M RAM, RedHat 7.1. Can this be a compiler
problem?

-Y.

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
--Just returned after being 10 days off-line. Sorry for the delayed reply.--
