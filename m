Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbRG0JNT>; Fri, 27 Jul 2001 05:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbRG0JNI>; Fri, 27 Jul 2001 05:13:08 -0400
Received: from zeus.kernel.org ([209.10.41.242]:24236 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267873AbRG0JMy>;
	Fri, 27 Jul 2001 05:12:54 -0400
Message-ID: <3B613041.C1330757@amiga.com.pl>
Date: Fri, 27 Jul 2001 11:11:29 +0200
From: Miloslaw Smyk <thorgal@amiga.com.pl>
Organization: W.F.M.H.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Hard disk problem:
In-Reply-To: <Pine.LNX.4.33.0107270005210.25463-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Mike A. Harris" wrote:
> 
> Is this a hardware or software problem, or could it be either?
> 
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
> { DriveReady SeekComplete Error }
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
> { UncorrectableError }, LBAsect=8545004, sector=62608
> Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
> (hda), sector 62608
> 
> Just got it opening up a mail folder.  Drive made a bit of noise
> and then PINE had to be killed.
> 
> 2 root@asdf:~# hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437

Ah, one of these excellent Hungarian DTLA drives? :) AFAIK, the entire batch
was broken, although there are people who insist that there was no single
working hard drive leaving that factory! I personally have seen 7 out of 7
failing...

Take it back to where you bought it and demand a replacement for something
NOT bearing "MADE IN HUNGARY" sign.

cheers,
Milek
-- 
mailto:thorgal@amiga.com.pl   |  "Man in the Moon and other weird things" -
http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
         Fight for the good cause: http://www.laubzega.com/dvd/
