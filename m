Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTICINQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbTICINP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:13:15 -0400
Received: from denise.shiny.it ([194.20.232.1]:27329 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261613AbTICILg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:11:36 -0400
Message-ID: <XFMail.20030903101129.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20030903050859.GD10257@work.bitmover.com>
Date: Wed, 03 Sep 2003 10:11:29 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: Scaling noise
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03-Sep-2003 Larry McVoy wrote:
> That was about 1995
> or so.  At that point, memory latency was about 200 ns and processor speeds
> were at about 200Mhz or 5 ns.  Today, memory latency is about 130 ns and
> processor speeds are about .3 ns.  Processor speeds are 15 times faster and
> memory is less than 2 times faster.  SMP makes that ratio worse.

Latency is not bandwidth. btw you are right, that's why caches are
growing, too. It's likely in the future there will be only UP (HT'd ?)
and NUMA machines.


Bye.
    Giuliano.
