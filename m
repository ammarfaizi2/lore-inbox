Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275448AbTHJBht (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275450AbTHJBht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:37:49 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:33667 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S275448AbTHJBhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:37:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: linux-kernel@vger.kernel.org
Subject: Re: nvidia gforce2 MMX 32meg failure
Date: Sat, 9 Aug 2003 21:37:47 -0400
User-Agent: KMail/1.5.1
References: <200308092029.39597.gene.heskett@verizon.net>
In-Reply-To: <200308092029.39597.gene.heskett@verizon.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308092137.47580.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.63.55] at Sat, 9 Aug 2003 20:37:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 20:29, Gene Heskett wrote:
>Greets;
[...]
>Side comment:  When I shutdown x, and then reboot after sending this
>msg, the fact that I've been running a 2.6 kernel will probably be
>confirmed by the shutdown scripts being unable to unmount my /usr on
>/dev/hda8, and this will be the case until such time as I let e2fsk
>scan it, reporting no problems when it does.
>
>To me, that says there is still something a bit fubar with the ide
>stuffs yet.

I'm happy to be able to say that this bit of oddness is gone, I've now 
rebooted back and forth several times to test3 without that problem.  
Kudzu however still insists on finding a 'generic 3 button mouse' at 
each 2.6 boot, and even though I tell it to do nothing, that same 
generic mnouse is found and removed when booting back to 2.4.22-rc2, 
and I then have to reselect the Logitek Mouseman wheel mouse (USB) 
again.

Is this something in my .config?  Or does kudzu need help for 2.6?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

