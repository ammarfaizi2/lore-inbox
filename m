Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131138AbQKWXVQ>; Thu, 23 Nov 2000 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129698AbQKWXUk>; Thu, 23 Nov 2000 18:20:40 -0500
Received: from [194.213.32.137] ([194.213.32.137]:18180 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S131081AbQKWXUX>;
        Thu, 23 Nov 2000 18:20:23 -0500
Date: Thu, 23 Nov 2000 01:05:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: Zach Brown <zab@zabbo.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI interface
Message-ID: <20001123010543.B96@toy>
In-Reply-To: <200011220223.SAA00416@baldur.yggdrasil.com> <20001122141341.E14640@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001122141341.E14640@tetsuo.zabbo.net>; from zab@zabbo.net on Wed, Nov 22, 2000 at 02:13:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	I also agree that the ioctl patch is kind of a bandaid over
> > the problems that you described, and, while Zach Brown can speak
> 
> The biggest problem is that the current code is gross gross gross.
> I've been avoiding dealing with it too much in the hopes that moving to
> oss_audio will make things much more friendly across the board.

What is oss_audio? I thought alsa is going in in 2.5...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
