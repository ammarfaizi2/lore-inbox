Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTA1OvC>; Tue, 28 Jan 2003 09:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTA1OuX>; Tue, 28 Jan 2003 09:50:23 -0500
Received: from home.wiggy.net ([213.84.101.140]:25536 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267342AbTA1Oth>;
	Tue, 28 Jan 2003 09:49:37 -0500
Date: Tue, 28 Jan 2003 15:58:56 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128145856.GE4868@wiggy.net>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <200301281144.h0SBi0ld000233@darkstar.example.net> <20030128114840.GV4868@wiggy.net> <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk> <20030128130953.GW4868@wiggy.net> <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk> <20030128143235.GY4868@wiggy.net> <20030128153533.X28781-100000@snail.stack.nl> <20030128144714.GC4868@wiggy.net> <1043765872.6760.27.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043765872.6760.27.camel@oubop4.bursar.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Richard B. Tilley  (Brad) wrote:
> Could you explain this in more detail? It seems to me that if the kernel
> does not support loadable modules that it would be inherently more
> secure because it could not be dynamically modified with a module. How
> is my understanding of this wrong?

You can fiddle with kernel memory by hand and insert code and modules.
There are a couple of tools available to do that for you, google can
probably find them for you.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
