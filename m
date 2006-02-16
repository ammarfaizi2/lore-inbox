Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWBRMzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWBRMzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWBRMzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39067 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751236AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Fri, 17 Feb 2006 00:04:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Jaegermann <michal@harddata.com>,
       Dave Jones <davej@codemonkey.org.uk>, arjan@infradead.org,
       len.brown@intel.com, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060216230418.GN3490@openzaurus.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com> <20060213001240.05e57d42.akpm@osdl.org> <1139821068.2997.22.camel@laptopd505.fenrus.org> <20060214030821.GA23031@mail.harddata.com> <20060213192838.64013c6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213192838.64013c6c.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> That's suspend-to-disk, yes?
> 
> Dave, would you have the 2.6.15-1.1830_FC4 -> 2.6.15-1.1831_FC4 details
> handy?  There surely can't be much difference?
> 
> There seem to be several ACPI problems there.  Do we have a reliable means
> of feeding such reports up into the (for example) acpi developers?
> 
> <I have this vaguely unsettled feeling that distros must get more bug
> reports than the usptream developers, yet we hear so little about it>

Its about 1:1 upstream:suse bugs for me... Unfortunately
suse bugs are often for old kernel...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

