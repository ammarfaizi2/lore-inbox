Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTIBMtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTIBMou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:44:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53983 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261501AbTIBMn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:43:56 -0400
Date: Mon, 1 Sep 2003 22:09:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Re: Athlon XP-M and cpufreq freezing Asus laptop to death
Message-ID: <20030901200941.GF1358@openzaurus.ucw.cz>
References: <20030824164828.GA922@renditai.milesteg.arr> <20030825071009.GH19292@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825071009.GH19292@poupinou.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a known issue (at least for me :).  When the difference
> between 2 vid and/or 2 fid are too big, that hang.
> 
> For now, as a quick (and mostly dirty though) solution is to go
> with the userspace governor only and to go to the lowest frequency with
> one or two step in-between.
> 
> I'm also wondering if those athlons have the same kind of stuff than
> the opteron (Dave)?

k8 has similar restriction to small steps, only.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hi!

> This is a known issue (at least for me :).  When the difference
> between 2 vid and/or 2 fid are too big, that hang.
> 
> For now, as a quick (and mostly dirty though) solution is to go
> with the userspace governor only and to go to the lowest frequency with
> one or two step in-between.
> 
> I'm also wondering if those athlons have the same kind of stuff than
> the opteron (Dave)?

k8 has similar restriction to small steps, only.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

