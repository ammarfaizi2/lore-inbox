Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSG2QTi>; Mon, 29 Jul 2002 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSG2QTi>; Mon, 29 Jul 2002 12:19:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56847 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317500AbSG2QTi>; Mon, 29 Jul 2002 12:19:38 -0400
Date: Mon, 29 Jul 2002 18:23:01 +0200
From: Martin Mares <mj@ucw.cz>
To: Dave Jones <davej@suse.de>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc/pci removal?
Message-ID: <20020729162301.GA5377@atrey.karlin.mff.cuni.cz>
References: <20020729131717.A25451@flint.arm.linux.org.uk> <20020729152938.G17798@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729152938.G17798@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

> ISTR Linus was quite attached to it, so it got un-obsoleted.

Exactly.  I've marked it as obsolete years ago, but when I wanted
to rip it out, Linus said he likes /proc/pci and it has to stay.

I still think that it's an extremely ugly interface, especially
because it requires the kernel to contain the list of vendor and device
names.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Who is General Failure and why is he reading my disk?
