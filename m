Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131017AbRCFQ4F>; Tue, 6 Mar 2001 11:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRCFQzm>; Tue, 6 Mar 2001 11:55:42 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:7032 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131018AbRCFQzI>; Tue, 6 Mar 2001 11:55:08 -0500
Message-ID: <3AA515FB.10D46B00@sgi.com>
Date: Tue, 06 Mar 2001 08:53:15 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: God <atm@pinky.penguinpowered.com>, linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <E14aKe6-00010k-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >       Then it seems the less ideal question is what is the "approved and recommended
> > way for a program to "poll" such devices to check for 'changes' and 'media type'
> > without the kernel generating spurious WARNINGS/ERRORS?
> 
> The answer to that could probably fill a book unfortunately. You need to use
> the various mtfuji and other ata or scsi query commands intended to notify you
> politely of media and other status changes
---
	Taking myself out of the role of someone who knows anything about the kernel --
and only knows application writing in the fields of GUI's and audio, what do you think
I'm going to use to check if their has been a playable CD inserted into the CD drive?

	There is an application called 'famd' -- which says it needs some kernel 
support to function efficiently -- perhaps that technology needs to be further developed
on Linux so app writers don't also have to be kernel experts and experts in all the
various bus and device types out there?

	Just an idea...?
-linda 
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
