Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBWImc>; Fri, 23 Feb 2001 03:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRBWImX>; Fri, 23 Feb 2001 03:42:23 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:62724 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129272AbRBWImQ>;
	Fri, 23 Feb 2001 03:42:16 -0500
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x
From: Brad Douglas <brad@neruo.com>
To: barryn@pobox.com
Cc: Tom Sightler <ttsig@tuxyturvy.com>, Jeff Lessem <Jeff.Lessem@Colorado.EDU>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200102230701.XAA02164@cx518206-b.irvn1.occa.home.com>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 23 Feb 2001 00:40:27 -0800
Mime-Version: 1.0
Message-Id: <20010223084216Z129272-30605+335@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Feb 2001 23:01:14 -0800, Barry K. Nathan wrote:
> Tom Sightler wrote:
> > What's strange is that I have the exact same type of machine and I don't see
> > this problem, could you forward me your kernel config as well?  I'll compare
> > that, and your info from your previous message to mine and see if we can
> > find a difference.
> 
> Another variable, perhaps, is the BIOS version. (If you have Quick Boot or
> whatever it's called enabled (which is the factory default), you'll have
> to hit F2 when the "Dell" screen appears at startup, to try to enter the
> BIOS setup (before Setup starts, it will show the BIOS version number and
> a bunch of other stuff).)
> 
> I have a working machine, with BIOS A04. (Strangely enough, my Inspiron
> 5000e came with BIOS A03, and a floppy disk with A04, along with
> instructions with a "do not use this BIOS flasher unless you have [some
> werid video-related problem]" type of disclaimer. Since I was having those
> APM oopses under Linux, I decided to try upgrading. It didn't fix the
> oopses, though.)

I have a BIOS that'll fix your APM problems, at a minimum.  Anyone who
wants it can email me privately, since the site I put it up on no longer
exists...

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


