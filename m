Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUDFUpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUDFUpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:45:52 -0400
Received: from bender.bawue.de ([193.7.176.20]:18126 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263995AbUDFUpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:45:51 -0400
Date: Tue, 6 Apr 2004 22:45:45 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
Message-ID: <20040406204545.GA15946@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Gene Heskett <gene.heskett@verizon.net>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040406193649.GA13257@sommrey.de> <200404061626.37714.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404061626.37714.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:26:37PM -0400, Gene Heskett wrote:
> 
> But join the 70C club, that AMD athlon keeps itself at a medium simmer 
> full time.  Mine has been running 67-72C for 3 years now.  Strangly, 
> shutting down setiathome doesn't cool it by more than a couple 
> degrees C.  And, its got a $50 all copper Glaciator cooler on it, 
> heavy heavy heavy.

That's not quite my point.  I am not afraid of running my athlons at
70C.  I just don't want to.  With Debian Woody they ran at <40C, which
is impressing IMHO.  An upgrade to Sarge raised the temp for about 5K,
which is still very cool.  This temperature didn't change when I
upgraded to an early 2.6 kernel.  Just after 2.6.3-mm4 there was this
jump for 10K that I just do not understand.  It doesn't hurt the athlons
but seems unnecessary to me.

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-04-06 18:59 /home/jo/.signature
