Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278375AbRJMTdv>; Sat, 13 Oct 2001 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278382AbRJMTdr>; Sat, 13 Oct 2001 15:33:47 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9220 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S278374AbRJMTcd>;
	Sat, 13 Oct 2001 15:32:33 -0400
Date: Wed, 10 Oct 2001 17:19:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Radovan Garabik <garabik@melkor.dnp.fmph.uniba.sk>
Cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] dead keys in unicode console mode
Message-ID: <20011010171934.D35@toy.ucw.cz>
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk> <20011009041618.A6135@win.tue.nl> <20011009092858.A15708@melkor.dnp.fmph.uniba.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011009092858.A15708@melkor.dnp.fmph.uniba.sk>; from garabik@melkor.dnp.fmph.uniba.sk on Tue, Oct 09, 2001 at 09:28:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And now all existing binaries that use the KDGKBDIACR ioctl
> > dump core? And all existing binaries that use the KDSKBDIACR
> > ioctl do very strange things?
> 
> well, of course, existing binaries need to be recompiled,
> that's what sources are for...

And go to hell when you boot older kernel? Not an option. Add new ioctl.

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

