Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUKGIWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUKGIWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 03:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUKGIWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 03:22:18 -0500
Received: from quechua.inka.de ([193.197.184.2]:13759 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261555AbUKGIWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 03:22:16 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: deadlock with 2.6.9
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200411070058_MC3-1-8E27-AAEF@compuserve.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CQiJS-0007FJ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 07 Nov 2004 09:22:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200411070058_MC3-1-8E27-AAEF@compuserve.com> you wrote:
> Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.)  They are
> much more reliable than software RAID.

On what sample do you base this claim?

Generally hardware raid sooner or later makes problems (especially if you
run raid5 in degenerate mode or try to rebuild by disk replacing with
differen/old signature). Also bus hangs are commonly not very well received
by hw raid firmware or drivers.

Issues with software raid are usually quicker to spot.

Greetings
Bernd
