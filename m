Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTLSRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTLSRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:04:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:58336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263452AbTLSRE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:04:27 -0500
Date: Fri, 19 Dec 2003 09:03:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ben Collins <bcollins@debian.org>
Cc: dale_d@telusplanet.net, linux-kernel@vger.kernel.org
Subject: Re: ieee1394 subsystem causes segfaults
Message-Id: <20031219090308.6966e068.rddunlap@osdl.org>
In-Reply-To: <20031217141057.GC551@phunnypharm.org>
References: <1071670222.2519.5.camel@localhost>
	<20031217141057.GC551@phunnypharm.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 09:10:57 -0500 Ben Collins <bcollins@debian.org> wrote:

| > 5. no oops message
| 
| Not sure how things can segv without some sort of kernel message. Are
| you sure it didn't print anything at all?

What messages are there then?  You should post the kernel log
showing the problem(s).  (Yes, I looked at the original posting.)

I have seen kernel bugs cause user space segfaults, so maybe
it's an app that is having the segfault.

--
~Randy
MOTD:  Always include version info.
