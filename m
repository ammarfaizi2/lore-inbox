Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268351AbRGXRBW>; Tue, 24 Jul 2001 13:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbRGXRBM>; Tue, 24 Jul 2001 13:01:12 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:2573 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S268340AbRGXRBA>; Tue, 24 Jul 2001 13:01:00 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Tue, 24 Jul 2001 19:01:03 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.7 cyclades-Y crash
Message-ID: <20010724190103.J1033@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	Hello,

	I've tried to move my serial console & modem server to the 2.4 kernel.
It has two Cyclades-Y cards - one ISA Cyclom 8Yo, and another Cyclom YeP (PCI,
connected to 16-port box). The 2.4.7 kernel crashes when initializing the
cyclades driver (either as a module or a built-in driver). I've tried
the stock kernel from Red Hat 7.1, and the cyclades.o module causes the
system to lock up when loaded.

	Has anybody the cyclades.o driver working with 2.4?

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
--Just returned after being 10 days off-line. Sorry for the delayed reply.--
