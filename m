Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUHaBfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUHaBfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHaBfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:35:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36019 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266170AbUHaBfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:35:07 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>
	 <1092781172.2301.1654.camel@cube>
	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	 <20040819191537.GA24060@elektroni.ee.tut.fi>
	 <20040826040436.360f05f7.akpm@osdl.org>
	 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1093916047.14662.144.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 18:34:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 16:00, Tim Schmielau wrote:
> George, please excuse my lack of understanding. What again where the
> precise reasons to have an ntp-corrected uptime?

Ah, here's the thread with the first mention of it that I could find.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.1/1471.html

thanks
-john

