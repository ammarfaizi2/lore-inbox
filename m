Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278210AbRJLX6M>; Fri, 12 Oct 2001 19:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278209AbRJLX6A>; Fri, 12 Oct 2001 19:58:00 -0400
Received: from webcon.net ([216.187.106.140]:18049 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S278205AbRJLX5t>;
	Fri, 12 Oct 2001 19:57:49 -0400
Date: Fri, 12 Oct 2001 19:58:17 -0400 (EDT)
From: Ian Morgan <imorgan@webcon.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: System won't reboot from Linux?
Message-ID: <Pine.LNX.4.40.0110121754430.1606-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'v got a laptop here (Sager NP8560V (aka Clevo 8500)) that can reboot and
poweroff just fine from Windows and GRUB. It will poweroff just fine in
Linux, but refuses to reboot. i.e. gets to the end of the shutdown scripts,
says "Restarting system", then just hangs.

Of course, like most laptops, it has no reset button, so I have to use the
power button to physically power the system off then back on, which I really
hate doing.

Any ideas how to debug this? Anybody know what Windows and GRUB do to reboot
a system that Linux doesn't? I'm going to dig through the code now, but was
hoping somebody might have a quick answer.

Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------


