Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUJKPAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUJKPAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJKO6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:58:02 -0400
Received: from gprs214-190.eurotel.cz ([160.218.214.190]:32128 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269039AbUJKO4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:56:49 -0400
Date: Mon, 11 Oct 2004 16:56:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: suspend-to-RAM [was Re: Totally broken PCI PM calls]
Message-ID: <20041011145628.GA2672@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Are you using suspend-to-ram or suspend-to-disk?
> 
> Suspend-to-disk. suspend-to-ram still doesn't work for me (never has, oh,
> well.. Slow progress).

Which machine is that, btw? Evo N620c has probably BIOS/firmware bug
that kills machine on attempt to enter S3 or S4. It takes pressing
power button 3 times (!) to get machine back.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
