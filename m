Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUCUDvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUCUDvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 22:51:07 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7622 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263596AbUCUDvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 22:51:06 -0500
Date: Sat, 20 Mar 2004 22:51:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, thomas.schlichter@web.de,
       phil.el@wanadoo.fr, schwab@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <20040317102550.2ca7737c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403202248050.28447@montezuma.fsmlabs.com>
References: <200403090014.03282.thomas.schlichter@web.de>
 <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
 <200403091208.20556.thomas.schlichter@web.de> <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
 <20040317102550.2ca7737c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Andrew Morton wrote:

> I still have a couple of NMI patches in -mm:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi_watchdog-local-apic-fix.patch

That looks like a decent bug fix.

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi-1-hz.patch

Didn't _you_ want that one? ;)
