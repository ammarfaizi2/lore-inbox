Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKMRbQ>; Tue, 13 Nov 2001 12:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277431AbRKMRay>; Tue, 13 Nov 2001 12:30:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:59409 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S277371AbRKMRap>; Tue, 13 Nov 2001 12:30:45 -0500
Message-ID: <3BF1651B.D6E05A1E@evision-ventures.com>
Date: Tue, 13 Nov 2001 19:23:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge BUG in 2.4.15-pre4 serial.c
In-Reply-To: <E163h5m-0001kJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Well I still think that the 8 lines can be deleted. Once again my famous
> > notbook is perfectly __i386__ and doesn't contain any devices served by
> > serial.c
> > unless I configure IrDA. Pushing the port numbers artificially behind
> > doesn't make sense for me and makes some setserial unknown tricks
> > neccessary
> 
> Renumbering everyones serial ports by suprise seems to be a 2.5 thing

OK that's an argument to which I fully agree.
