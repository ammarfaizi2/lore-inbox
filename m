Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVABXOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVABXOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVABXOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:14:10 -0500
Received: from smtp.terra.es ([213.4.129.129]:52404 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261342AbVABXOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:14:07 -0500
Date: Mon, 3 Jan 2005 00:14:03 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Adrian Bunk <bunk@stusta.de>
Cc: wli@debian.org, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-Id: <20050103001403.7900df7e.diegocg@teleline.es>
In-Reply-To: <20050102221534.GG4183@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	<20050102203615.GL29332@holomorphy.com>
	<20050102212427.GG2818@pclin040.win.tue.nl>
	<20050102214211.GM29332@holomorphy.com>
	<20050102221534.GG4183@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 2 Jan 2005 23:15:34 +0100 Adrian Bunk <bunk@stusta.de> escribió:

> The main advantage with stable kernels in the good old days (tm) when 4 
> and 6 were even numbers was that you knew if something didn't work, and 
> upgrading to a new kernel inside this stable kernel series had a 
> relatively low risk of new breakages. This meant one big migration every 
> few years and relatively easy upgrades between stable series kernels.

That's not always true, 2.4.x development has not been exactly what I'd
call "stable". IIRC 2.4.15 - the 2.6 fork I think - could corrupt your
filesystems and I don't remember right now if there were more, personally
I've suffered of "weird" behaviours until the new VM was stabilized, and
I've heard of lots of reiser and ext3 problems until both filesystems got
stabilized. I've lost my filesystems 3 times with 2.4, 0 times running 2.5
since 2.5.3x (of course that could be just good luck or bad luck but...)

Of course that only proves your point: that changes may cause bugs 8) but
for me 2.6 has been by far the stablest release linux has ever had, with
some minor issues in each release while at the same time incorporating "big"
changes which is something I can accept as "desktop user". Perhaps 2.6 will
become "rock stable" or "to be used only by servers not desktops" when 2.7
forks?


