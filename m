Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTLBV4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTLBV4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:56:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:18102 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264410AbTLBV4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:56:22 -0500
Date: Tue, 2 Dec 2003 13:56:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Stephan von Krawczynski <skraw@ithnet.com>, jbglaw@lug-owl.de,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <200312021648.07050.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0312021352350.1519@home.osdl.org>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
 <200312021439.52933.gene.heskett@verizon.net> <20031202213228.5747cbfe.skraw@ithnet.com>
 <200312021648.07050.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Gene Heskett wrote:
>
> So what are you using?  And how does it work, at least for a
> non-gamer?

If you're a nongamer, almost anything will work. Intel's integrated
graphics is pretty well supported even with 3D (and better than most in
2D), and Intel documents their hardware. It helps if you have one of the
newer dual-DDR-400 setups, since the Intel stuff is UMA and will eat
main-memory bandwidth.

The ATI R200-based cards tend to work well with DRI too, and are typically
higher performance than the integrated chipsets (ie you can actually play
most games comfortably).

			Linus
