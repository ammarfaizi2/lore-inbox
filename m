Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbRBTUJV>; Tue, 20 Feb 2001 15:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130589AbRBTUJL>; Tue, 20 Feb 2001 15:09:11 -0500
Received: from [194.213.32.137] ([194.213.32.137]:53252 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130573AbRBTUJD>;
	Tue, 20 Feb 2001 15:09:03 -0500
Date: Sat, 1 Jan 2000 01:11:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
Cc: Mark Vojkovich <mvojkovich@nvidia.com>, xpert@xfree86.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Xpert]Video drivers and the kernel
Message-ID: <20000101011143.A32@(none)>
In-Reply-To: <Pine.LNX.4.21.0102131937590.1564-100000@mvojkovich1.nvidia.com> <3A8AD550.87898BB0@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A8AD550.87898BB0@sympatico.ca>; from jeremy.jackson@sympatico.ca on Wed, Feb 14, 2001 at 01:58:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (Aside, is this because X uses keyboard in raw mode?  would be nice to still
> be able to ctrl-alt-del to rebood from console)  Anyone know about
> using alt-sysrq to restore console?

Alt-SysRq-U,S,B. Should work as long as kernel is alive. It is not completely 
clean shutdown, but will prevent fsck.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

