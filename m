Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbRBJNb0>; Sat, 10 Feb 2001 08:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131399AbRBJNbQ>; Sat, 10 Feb 2001 08:31:16 -0500
Received: from mspool.gts.cz ([212.47.0.11]:2579 "EHLO mspool.gts.cz")
	by vger.kernel.org with ESMTP id <S131168AbRBJNbJ>;
	Sat, 10 Feb 2001 08:31:09 -0500
Date: Sat, 10 Feb 2001 14:30:46 +0100
From: Martin Mares <mj@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        gandalf@winds.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
Message-ID: <20010210143046.A2164@albireo.ucw.cz>
In-Reply-To: <1500B3C52526@vcnet.vc.cvut.cz> <20010209173600.A2887@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010209173600.A2887@suse.cz>; from vojtech@suse.cz on Fri, Feb 09, 2001 at 05:36:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Not the case, sorry. An IDE drive is needed. However, it still might be
> worth to pass the PCI speed to other drivers ...

But beware, the timing should be a per-bus value.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
The first myth of management is that it exists.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
