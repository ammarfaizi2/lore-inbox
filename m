Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTIOPpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbTIOPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:45:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:40922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261486AbTIOPpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:45:17 -0400
Date: Mon, 15 Sep 2003 08:38:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Jon Masters" <jcm@printk.net>
Cc: linux-kernel@vger.kernel.org, jcm@jonmasters.org
Subject: Re: /proc/sys sysrq
Message-Id: <20030915083854.07c46285.rddunlap@osdl.org>
In-Reply-To: <60603.62.173.87.60.1063639907.squirrel@mail.printk.net>
References: <60603.62.173.87.60.1063639907.squirrel@mail.printk.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 16:31:47 +0100 (BST) "Jon Masters" <jcm@printk.net> wrote:

| Hi,
| 
| 
| Someone recently posted a message to Linux Managers about rebooting a box
| with a failed drive and no serial console from a remote location. It
| turned out in that instance that there was another drive and enough
| working to copy a simple reboot binary to it.
| 
| Anyway I was wondering whether there is an official "alternative sysrq" in
| /proc/sys or if it would be worth me writing a patch to add things like a
| reboot entry one could cat "feeldead" to or whatever...is this even worth
| doing or been done?

It's already there (in 2.4.recent and 2.5/2.6:  /proc/sysrq-trigger)

--
~Randy
