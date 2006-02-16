Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWBRMzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWBRMzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBRMzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38555 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751229AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Fri, 17 Feb 2006 00:21:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: time patches by Roman Zippel
Message-ID: <20060216232102.GP3490@openzaurus.ucw.cz>
References: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So personally I'd suggest to consider that code base. Options are eiher
> 1) to optimize/streamline what you think is too ugly
> 2) make the whole NTP lcok calibration optional if you think it's computationally
> too heavy (however, both GNOME and KDE hit the CPU much more than any of these
> changes)

Well, being less resource-hungry is similar to be less lethal than loaded gun.

Kernel time keeping should better have <0.1% cpu overhead.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

