Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTI3KFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbTI3KFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:05:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61056 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261299AbTI3KFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:05:46 -0400
Date: Tue, 30 Sep 2003 03:01:53 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930030153.6510dbae.davem@redhat.com>
In-Reply-To: <1064916168.21551.105.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030929220916.19c9c90d.davem@redhat.com>
	<1064903562.6154.160.camel@imladris.demon.co.uk>
	<20030930000302.3e1bf8bb.davem@redhat.com>
	<1064907572.21551.31.camel@hades.cambridge.redhat.com>
	<20030930010855.095c2c35.davem@redhat.com>
	<1064910398.21551.41.camel@hades.cambridge.redhat.com>
	<20030930013025.697c786e.davem@redhat.com>
	<1064911360.21551.49.camel@hades.cambridge.redhat.com>
	<20030930015125.5de36d97.davem@redhat.com>
	<1064913241.21551.69.camel@hades.cambridge.redhat.com>
	<20030930022410.08c5649c.davem@redhat.com>
	<1064916168.21551.105.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 11:02:49 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> I am saying that even if I run 'make all', I do not accept that the
> resulting kernel image should be _different_ when I change any option
> from 'n' to 'm'.

Then let's agree to disagree.

Send the proposal to Linus and let him hash it out with you, although
I belive I have a good idea which side of the fence he'll be on. 8-)

