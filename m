Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTLORR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTLORR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:17:59 -0500
Received: from gprs214-241.eurotel.cz ([160.218.214.241]:11648 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263796AbTLORRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:17:51 -0500
Date: Mon, 15 Dec 2003 18:18:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Message-ID: <20031215171849.GA345@elf.ucw.cz>
References: <fa.da53dsa.dho216@ifi.uio.no> <20031212214310.GA744@node1.opengeometry.net> <20031213131405.GA11073@hh.idb.hist.no> <20031213211234.GB448@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213211234.GB448@node1.opengeometry.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The functionality can be found at linuxconsole.sourceforge.net.
> > > > Will this be included into mainline near term? Say 2.6.[12]?
> > > > The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.
> > > 
> > > Does it work?
> > > 
> > It works with 2.6.0-test11.  Prepare a kernel source tree,
> > check out ruby from cvs, copy the ruby-2.6 parts into
> > the kernel tree.
> > 
> > I run my home machine this way:
> > 2 standard keyboards, one connected to the keyboard port and
> > another connected to the ps2 mouse port.
> 
> Plug PS/2 keyboard into PS/2 mouse port???  I didn't know you can do
> that.

Yep, that works, with proper software.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
