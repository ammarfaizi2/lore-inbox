Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBHLcL>; Thu, 8 Feb 2001 06:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBHLbw>; Thu, 8 Feb 2001 06:31:52 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129363AbRBHLbt>;
	Thu, 8 Feb 2001 06:31:49 -0500
Message-ID: <20010208004021.D189@bug.ucw.cz>
Date: Thu, 8 Feb 2001 00:40:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Juergen Schneider <juergen.schneider@tuxia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010201183231.A373@tuxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010201183231.A373@tuxia.com>; from Juergen Schneider on Thu, Feb 01, 2001 at 06:32:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

> I've created a patch for kernel 2.4.1 that adds some fancy options for
> the framebuffer console driver concerning the boot logo.
> I've added logo animation and logo centering.
> People may find this not very useful but nice to look at. :-)

Long time ago I joked that win2000 will have 30-minute film at the
bootup. [3.1 had picture, 95+ had static logo with moving line...] And
now it looks like _linux_ is getting that feature...
								Pavel,
wondering when linux boot gets so long that mpeg2 player gets
integrated into kernel.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
