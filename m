Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRGYPVe>; Wed, 25 Jul 2001 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbRGYPVZ>; Wed, 25 Jul 2001 11:21:25 -0400
Received: from zeus.kernel.org ([209.10.41.242]:10899 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266977AbRGYPVS>;
	Wed, 25 Jul 2001 11:21:18 -0400
Message-ID: <3B5ED6F0.BA7E75A4@amiga.com.pl>
Date: Wed, 25 Jul 2001 16:25:52 +0200
From: Miloslaw Smyk <thorgal@amiga.com.pl>
Organization: W.F.M.H.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <Pine.LNX.4.30.0107231503240.13434-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dan Hollis wrote:
> 
> On Mon, 23 Jul 2001, Alan Cox wrote:
> > On Mon, Jul 23, 2001 at 06:02:01PM +0200, Felix von Leitner wrote:
> > > When I compile the same kernel for Pentium Pro, it works.  How can this
> > > be?
> > Theory right now: Because the Athlon kernel does streaming memory copies at
> > full bus performance. Not all VIA chipset boards seem to cope.
> 
> I fixed my MSI/athlon stability problems by reducing PS load. My next
> purchase will be a 450W PS to replace my 300W.
> 
> Athlons are real power suckers, 300W is probably 'barely enough' for
> typical PC.

I'd rather say it may be related to how your MSI board supplies power to the
Athlon, rather than the Athlon itself. I've been using ABit KT7A +
Athlon@1.1GHz for half a year now, without a _single_ stability problem -
and this machine is my primary workstation, being switched off basically
only when I sleep.

I have Matrox G400/YMF724/NIC/CDR/DVD/three HDs (two in RAID) and... 250W
PS.

A friend has purchased basically the same config, he has one HD less but his
CPU is overclocked to 1150MHz. He uses both Linux and Windows and also does
not report any problems.

cheers,
Milek
Ps. One probably important thing is that I'm only using HPT370 IDE
controller under Linux.
-- 
mailto:thorgal@amiga.com.pl   |  "Man in the Moon and other weird things" -
http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
         Fight for the good cause: http://www.laubzega.com/dvd/
