Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbSLKUQk>; Wed, 11 Dec 2002 15:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbSLKUQk>; Wed, 11 Dec 2002 15:16:40 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:48579
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267319AbSLKUQj>; Wed, 11 Dec 2002 15:16:39 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Egger <degger@fhm.edu>, Dave Jones <davej@codemonkey.org.uk>,
       Joseph <jospehchan@yahoo.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1021211134909.19397B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021211134909.19397B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 21:00:41 +0000
Message-Id: <1039640441.18412.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 18:51, Bill Davidsen wrote:
> Is this the CPU in the $200 "Lindows" PC Wal-Mart is selling? I was
> thinking of one for a low volume router, and it looks as if there are two
> VIA chips called C3 (or advertizers have hacked the specs).

It is. Its a nice CPU for appliances. FPU is nondescript, integer
performance is sort of the same as an equivalently clocked celewrong for
the current Ezra core at least. The older Samuel II core seems a little
slower.

There is also a subspecies that comes in at 500-600MHz and is designed
for low power fanless operation (though with a decent sized heatsink the
same is true for the 1GHz ones).

If you think the Walmart PC is cool take a look at the EPIA board or see
www.mini-itx.com. 60W for a complete PC

