Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWJ3TAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWJ3TAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWJ3TAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:00:17 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:7570 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1161393AbWJ3S7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:59:53 -0500
Date: Mon, 30 Oct 2006 21:00:10 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Message-ID: <20061030190010.GB4442@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061030183522.GL27968@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030183522.GL27968@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Martin, Michael, can you send complete "dmesg -s 1000000" for both 
> 2.6.18.1 and a non-working 2.6.19-rc kernel after resume?
> I don't have high hopes, but perhaps looking at the dmesg and/or 
> diff'ing them might give a hint.

OK, I'll try to go back to this, just not today.

-- 
MST
