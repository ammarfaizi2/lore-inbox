Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbTHUQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTHUQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:26:48 -0400
Received: from [66.212.224.118] ([66.212.224.118]:25870 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262823AbTHUQ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:26:47 -0400
Date: Thu, 21 Aug 2003 11:59:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pankaj Garg <PGarg@MEGISTO.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Messaging between kernel modules and User Apps
In-Reply-To: <Pine.LNX.4.53.0308211109320.2718@chaos>
Message-ID: <Pine.LNX.4.53.0308211157360.17457@montezuma.mastecende.com>
References: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
 <Pine.LNX.4.53.0308211109320.2718@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Richard B. Johnson wrote:

> The de facto standard for network devices is to use sockets.
> For character and and block devices Unix/Linux uses the
> open/poll/ioctl/read mechanisms.

That sounds fine, but..

> You could send your module a pid via proc and have it send a
> signal to your application as a result of an event.

... please don't even entertain such sick ideas.
