Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbUKQCLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUKQCLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUKQCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:11:04 -0500
Received: from outbound01.telus.net ([199.185.220.220]:2507 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S262155AbUKQBrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:47:03 -0500
Subject: Re: Boot failure, 2.6.10-rc2 (resolved)
From: Bob Gill <gillb4@telusplanet.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411162122200.32739@yvahk01.tjqt.qr>
References: <1100632116.4388.9.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0411162025180.24131@yvahk01.tjqt.qr>
	 <1100636345.4388.21.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0411162122200.32739@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 18:47:25 -0700
Message-Id: <1100656045.5008.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks, I can get 2.6.10-rc2 to boot/run.  I didn't need devfs to
build new kernels in Fedora Core 2 (and devfs is marked as obsolete),
but the new distribution -FC3- needs devfs to run.
Thanks,
Bob  

On Tue, 2004-11-16 at 21:24 +0100, Jan Engelhardt wrote:
> >> How, after all, did you run into this error? Directly after upgrading (if
> >> applicable)?
> >No, [...] but I prefer to run my own custom kernels.
> (So the post here is justified)
> 
> >Thanks for your reply though.  Your question as to whether /dev/console
> >exists at boot time is making me question whether /dev/console exists at
> >boot time.
> 
> You could find out by taking a live distro and checking. That's because I
> suspect your old kernel, which probably still works, to contain ~~ something
> magical ~~ that /dev/console is created at the right time.
> devfs probably?
> 
> 
> Jan Engelhardt
-- 
Bob Gill <gillb4@telusplanet.net>

