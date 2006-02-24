Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWBXS0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWBXS0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBXS0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:26:09 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:59013 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932417AbWBXS0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:26:08 -0500
Date: Fri, 24 Feb 2006 19:26:09 +0100
From: Martin Mares <mj@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Asfand Yar Qazi <ay0106@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
Message-ID: <mj+md-20060224.181909.23160.albireo@ucw.cz>
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua> <43FC54B8.7070706@qazi.f2s.com> <mj+md-20060222.121130.6225.albireo@ucw.cz> <43FC574A.4000100@qazi.f2s.com> <Pine.LNX.4.61.0602240832150.16363@yvahk01.tjqt.qr> <mj+md-20060224.101038.705.atrey@ucw.cz> <Pine.LNX.4.61.0602241904570.3694@yvahk01.tjqt.qr> <mj+md-20060224.181006.23057.albireo@ucw.cz> <Pine.LNX.4.61.0602241915380.3694@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602241915380.3694@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >However, this would change meaning of numbers entered at the video mode
> >prompt (with vga=ask), which doesn't look good.
> >
> Add a warning ;-)

Well, the same thing can be said about the vga= parameter in LILO and GRUB :-)

I think that the kernel documentation (svga.txt) is pretty clear and explicit
on the meaning of the numbers and I don't see any reasons to change the
behavior of the mode selector.

What IMHO needs updating is the documentation on the vga parameter in LILO
and GRUB docs, which doesn't explain well what's going on.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"A semicolon. Another line ends in the dance of camel." -- Kabir Ahuja
