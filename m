Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbTA1PLb>; Tue, 28 Jan 2003 10:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTA1PLb>; Tue, 28 Jan 2003 10:11:31 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:16394 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267386AbTA1PLa>; Tue, 28 Jan 2003 10:11:30 -0500
Subject: Re: Bootscreen
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128151406.GF4868@wiggy.net>
References: <20030128114840.GV4868@wiggy.net>
	<1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
	<20030128130953.GW4868@wiggy.net>
	<1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk>
	<20030128143235.GY4868@wiggy.net>
	<20030128153533.X28781-100000@snail.stack.nl>
	<20030128144714.GC4868@wiggy.net>
	<1043765872.6760.27.camel@oubop4.bursar.vt.edu>
	<20030128145856.GE4868@wiggy.net>
	<1043766477.6794.32.camel@oubop4.bursar.vt.edu> 
	<20030128151406.GF4868@wiggy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jan 2003 10:20:49 -0500
Message-Id: <1043767249.7615.42.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, you win. 

Were can I find these simple tools that modify a kernel that does not
support loadable modules as easily as insmod modifies a kernel that does
support them?

On Tue, 2003-01-28 at 10:14, Wichert Akkerman wrote:
> Previously Richard B. Tilley  (Brad) wrote:
> > Then, not supporting loadable modules *is* more secure. By not
> > supporting them, you are decreasing the ease in which the kernel can be
> > modified. There are fewer people who can "fiddle with memory by hand"
> > than there are that can insert a loadable module... a lot fewer, don't
> > you agree?
> 
> No, there are simple tools to do that which are just as easy to use as
> insmod.
> 
> Wichert.
> 
> -- 
> Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
> A random hacker
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


