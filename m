Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTA1PEt>; Tue, 28 Jan 2003 10:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbTA1PEt>; Tue, 28 Jan 2003 10:04:49 -0500
Received: from home.wiggy.net ([213.84.101.140]:1729 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267352AbTA1PEr>;
	Tue, 28 Jan 2003 10:04:47 -0500
Date: Tue, 28 Jan 2003 16:14:06 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128151406.GF4868@wiggy.net>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20030128114840.GV4868@wiggy.net> <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk> <20030128130953.GW4868@wiggy.net> <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk> <20030128143235.GY4868@wiggy.net> <20030128153533.X28781-100000@snail.stack.nl> <20030128144714.GC4868@wiggy.net> <1043765872.6760.27.camel@oubop4.bursar.vt.edu> <20030128145856.GE4868@wiggy.net> <1043766477.6794.32.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043766477.6794.32.camel@oubop4.bursar.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Richard B. Tilley  (Brad) wrote:
> Then, not supporting loadable modules *is* more secure. By not
> supporting them, you are decreasing the ease in which the kernel can be
> modified. There are fewer people who can "fiddle with memory by hand"
> than there are that can insert a loadable module... a lot fewer, don't
> you agree?

No, there are simple tools to do that which are just as easy to use as
insmod.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
