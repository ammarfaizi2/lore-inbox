Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTIJPrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbTIJPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:47:13 -0400
Received: from luli.rootdir.de ([213.133.108.222]:24497 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S265105AbTIJPrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:47:09 -0400
Date: Wed, 10 Sep 2003 17:47:02 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030910154702.GB1507@rootdir.de>
References: <20030910103142.GA1053@rootdir.de> <20030910111312.GA847@rootdir.de> <20030910143837.GC2589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910143837.GC2589@elf.ucw.cz>
Reply-By: Sa Sep 13 17:46:05 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-No-archive: yes
X-Uptime: 17:46:05 up  4:29,  5 users,  load average: 0.11, 0.11, 0.04
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> > APIC error on CPU0: 08(08)
> > 
> > ...and it repeats endlessly :(
> > 
> > my keyboard is dead afterwards.
> 
> Can you test on -test3 kernel?

Ok, I will later today.


BTW: when I suspend from X11 with the nvidia-drivers, then
the screen looks even worse :(

