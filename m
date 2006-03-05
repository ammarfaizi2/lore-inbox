Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWCJP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWCJP2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCJP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:28:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43529 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751359AbWCJP2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:28:10 -0500
Date: Sun, 5 Mar 2006 03:08:49 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <gregkh@suse.de>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060305030849.GA2421@ucw.cz>
References: <patchbomb.1141950930@eng-12.pathscale.com> <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com> <20060310011106.GD9945@suse.de> <1141967377.14517.32.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141967377.14517.32.camel@camp4.serpentine.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm thinking at this point that I should just route this information
> through the /dev/ipath_sma char device, and maybe
> add /dev/ipath_counters%d and /dev/ipath_stats to go with it.  I think
> that's a pretty crummy approach that sysfs solves more cleanly, but
> there you go.

Too bad for your leg, I'm afraid :-).
								Pavel

-- 
Thanks, Sharp!
