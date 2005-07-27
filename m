Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVG0V2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVG0V2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG0VZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:25:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63916 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262447AbVG0VX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:23:26 -0400
Date: Wed, 27 Jul 2005 23:18:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: ACPI buttons in 2.6.12-rc4-mm2
Message-ID: <20050727211849.GC708@openzaurus.ucw.cz>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com> <b6d0f5fb0505220425146d481a@mail.gmail.com> <1122407079.13241.4.camel@toshiba.lenb.intel.com> <E1DxVWb-0002Sx-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DxVWb-0002Sx-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Len Brown <len.brown@intel.com> wrote:
> 
> > I deleted /proc/acpi/button on purpose,
> > did you have a use for those files?
> 
> There are various cases where it's useful to know whether a laptop is
> shut or not, and /proc/acpi/button seems to be the only place where that
> information is made available at the moment.
> 

Unless it was in obsolete-feature-removal file for a year.... changing userspace
interface is bad idea in the middle of stable series.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

