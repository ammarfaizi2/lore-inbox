Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbRBLKUb>; Mon, 12 Feb 2001 05:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbRBLKUW>; Mon, 12 Feb 2001 05:20:22 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130704AbRBLKUH>;
	Mon, 12 Feb 2001 05:20:07 -0500
Message-ID: <20010211234718.K3748@bug.ucw.cz>
Date: Sun, 11 Feb 2001 23:47:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Miles Lane <miles@megapathdsl.net>, Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A83C4A1.5090903@megapathdsl.net>; from Miles Lane on Fri, Feb 09, 2001 at 02:21:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Right.  Add the option.  Default to "spew mode",
> but make it easy for distributions to show people
> a non-threatening boot process.  

Wrong.
> 
> Since, as Christophe mentions, the boot messages would
> still be accessible via CTRL-ALT-F2, I don't see what 
> the problem is with at least making this an option.

If your system crashes hard, you have only graphical logo to stare
at. Any warning messages are hidden. Not good.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
