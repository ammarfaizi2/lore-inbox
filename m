Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUIQUv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUIQUv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUIQUsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:48:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15027 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269010AbUIQUrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:47:22 -0400
Date: Fri, 17 Sep 2004 16:10:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
Message-ID: <20040917141004.GA467@openzaurus.ucw.cz>
References: <20040914061641.GD2336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914061641.GD2336@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2.6.9-rc2 is throwing a lot of these errors on my system:
> 
> [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
> [ACPI Debug] String: Length 0x0F, "Entering TIN2()"
> [ACPI Debug] String: Length 0x0F, "Existing RTMP()"
> 
> About 450 of these three lines repeated so far, seem to get one every 5
> seconds or so. Box is an Athlon64 solo, let me know if you want more
> info (and what).
> 

That seems to be normal. These are debug prints from ACPI BIOS.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

