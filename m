Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTBCT7a>; Mon, 3 Feb 2003 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTBCT6N>; Mon, 3 Feb 2003 14:58:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266806AbTBCTx4>;
	Mon, 3 Feb 2003 14:53:56 -0500
Date: Mon, 3 Feb 2003 13:54:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Message-ID: <20030203125449.GB480@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz> <20030203073028.B4C2920BD9@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203073028.B4C2920BD9@dungeon.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had compactflash from Apacer (256MB), and it started corrupting data
> > in few months, eventually becoming useless and being given back for
> > repair. They gave me another one and it is just starting to corrupt
> > data.
> 
> last year we had some problems with compactflash. It was only 7bit
> clean, not 8bit. However the cards worked fine via usb devices,
> but not when used as IDE device.
> 
> test if writing 7bit data is reliable :-)

Ouch... I can't imageine how even VFAT would work on something not
8-bit-clean. I doubt FAT only uses 7bits...

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
