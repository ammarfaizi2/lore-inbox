Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJRHpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 03:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTJRHoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 03:44:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3547 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261473AbTJRHn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 03:43:58 -0400
Date: Thu, 16 Oct 2003 22:21:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aviram Jenik <aviram@beyondsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk very unstable
Message-ID: <20031016202105.GL1659@openzaurus.ucw.cz>
References: <200310152347.04263.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310152347.04263.aviram@beyondsecurity.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Suspend to disk (I'm using echo -n "disk" > /sys/power/state) works about one 
> in ten attempts. When it works, it is _usually_ capable of hibernating a few 
> consecutive times, but then it stops working (reboots on resume).

can you try echo 4 > /proc/acpi/sleep?

				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

