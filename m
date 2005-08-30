Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVH3OEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVH3OEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVH3OEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:04:13 -0400
Received: from mail.charite.de ([160.45.207.131]:5000 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751441AbVH3OEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:04:11 -0400
Date: Tue, 30 Aug 2005 16:03:53 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Message-ID: <20050830140353.GV5603@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200508292303.52735.chase.venters@clientec.com> <9a87484905083005064cf4e6d0@mail.gmail.com> <200508300900.36148.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200508300900.36148.chase.venters@clientec.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chase Venters <chase.venters@clientec.com>:

> > CONFIG_MPENTIUM4, CONFIG_SMP and CONFIG_SCHED_SMT enabled?
> 
> Yes in all three regards.

Same here. Dual-Xeon 2.8Ghz, only 2 CPUs are being displayed.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
