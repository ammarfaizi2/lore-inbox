Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTIKL6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTIKL6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:58:40 -0400
Received: from luli.rootdir.de ([213.133.108.222]:43192 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261219AbTIKL6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:58:40 -0400
Date: Thu, 11 Sep 2003 13:57:28 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030911115728.GA964@rootdir.de>
References: <20030910103142.GA1053@rootdir.de> <20030910111312.GA847@rootdir.de> <20030910143837.GC2589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910143837.GC2589@elf.ucw.cz>
Reply-By: Sun Sep 14 13:33:51 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-No-archive: yes
X-Uptime: 13:33:51 up  1:16,  7 users,  load average: 0.21, 0.16, 0.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> > 
> > APIC error on CPU0: 08(08)
> > ...and it repeats endlessly :(
> > 
> > my keyboard is dead afterwards.
> 
> Can you test on -test3 kernel?

no, I can't, because I need Andrew De Quincey's linux-2.6.0-test4-acpi-picmode-5.patch
to be able to boot acpi painless. :( But I could try with later
test-kernels.


