Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVH3O3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVH3O3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVH3O3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:29:20 -0400
Received: from mail.charite.de ([160.45.207.131]:21458 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932150AbVH3O3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:29:19 -0400
Date: Tue, 30 Aug 2005 16:11:18 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Message-ID: <20050830141118.GX5603@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200508292303.52735.chase.venters@clientec.com> <9a87484905083005064cf4e6d0@mail.gmail.com> <200508300900.36148.chase.venters@clientec.com> <20050830140353.GV5603@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050830140353.GV5603@charite.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> * Chase Venters <chase.venters@clientec.com>:
> 
> > > CONFIG_MPENTIUM4, CONFIG_SMP and CONFIG_SCHED_SMT enabled?
> > 
> > Yes in all three regards.
> 
> Same here. Dual-Xeon 2.8Ghz, only 2 CPUs are being displayed.

After activating ACPI and power Management, HT works again.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
