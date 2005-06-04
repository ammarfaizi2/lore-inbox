Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFDPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFDPpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFDPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:45:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261340AbVFDPpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:45:04 -0400
Date: Sat, 4 Jun 2005 17:24:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Henk <Henk.Vergonet@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050604152400.GC756@openzaurus.ucw.cz>
References: <20050531220738.GA21775@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531220738.GA21775@god.dyndns.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I know this 7-segments stuff probably won't be used widespread much but it
> could be important to have similar projects use the same notation, and
> use the same concepts.
....
> What do you think?

Keep 7-segment displays out of kernel. If it is usb, drive it from userspace with libusb...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

