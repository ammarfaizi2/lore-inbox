Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbSLEQj2>; Thu, 5 Dec 2002 11:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbSLEQj2>; Thu, 5 Dec 2002 11:39:28 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:43983 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267347AbSLEQj1>;
	Thu, 5 Dec 2002 11:39:27 -0500
Date: Thu, 5 Dec 2002 16:43:53 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Framebuffer oddness in 2.5.50
Message-ID: <20021205164353.GA9658@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something really odd just happened. I was on console,
and hit alt-f7, which flipped me back to X.
There were small blinking parts of the screen, which
I think was actually the fb cursor, but it was sort of skewed
across the screen. I could click in windows, but when
I typed, nothing would appear. I pressed alt-ctrl-f1,
and got back to the console, where everything I had just
typed (whilst I thought I was in X) was.

Totally wierd, and try as I might, I can't reproduce it at will.

Nvidia graphic card (no binary crap loaded), vesafb.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
