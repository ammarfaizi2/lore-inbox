Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTI3FVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTI3FVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:21:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34052 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263119AbTI3FVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:21:18 -0400
Date: Mon, 29 Sep 2003 22:17:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: acme@conectiva.com.br, bunk@fs.tum.de, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030929221712.51e6c27b.davem@redhat.com>
In-Reply-To: <1064826174.29569.13.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030928233909.GG1039@conectiva.com.br>
	<20030929001439.GY15338@fs.tum.de>
	<20030929003229.GM1039@conectiva.com.br>
	<1064826174.29569.13.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 10:02:55 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> The underlying point being that your static kernel should not change if
> you change an option from 'n' to 'm'. It should only affect the kernel
> image if you change options to/from 'y'.

I totally disagree, what ipv6 is doing is perfectly fine.
