Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUBUA1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUBUA1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:27:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:2453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbUBUA1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:27:25 -0500
Date: Fri, 20 Feb 2004 16:19:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Elliot Mackenzie" <macka@adixein.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Message-Id: <20040220161950.40bc8fbd.rddunlap@osdl.org>
In-Reply-To: <001401c3f811$29a57e70$4301a8c0@waverunner>
References: <20040220161139.3bd95852.rddunlap@osdl.org>
	<001401c3f811$29a57e70$4301a8c0@waverunner>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 10:25:09 +1000 "Elliot Mackenzie" <macka@adixein.com> wrote:

| c03e46c9 t do_initcalls, if I got the one you are looking for...
| 
Nope, this list:

| Calling initcall 0xc03f7e19
| Calling initcall 0xc03f819c
| Calling initcall 0xc03f1e7c
| Calling initcall 0xc03e7084
| Calling initcall 0xc03e7101
| Calling initcall 0xc03e90e2

Thanks.

| 
| 
| | Duh, I forgot.  Please look up these initcall addresses in your
| | System.map file (or post it on the web or mail it).
| |
| | But that size=0xedeb0000 is a problem... just to figure out where
| | it's coming from, using the initcall symbols.
| <snip>


--
~Randy
