Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTEQU5S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTEQU5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:57:18 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28094 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261832AbTEQU5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:57:17 -0400
Date: Sat, 17 May 2003 10:56:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030517085610.GC686@zaurus.ucw.cz>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - ACPI needs the relax patches merging to work on lots of laptops
> 
> Working in 2.4.21-ac, Toshiba cheap laptops now run a treat. Forward
> port looks like a patch command

Well, this looks like easy to patch but
hard to convince Andy to take it...

Perhaps such workarounds could be surrounded
by CONFIG_BROKEN_HW (default to yes).
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

