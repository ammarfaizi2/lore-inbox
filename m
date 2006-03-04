Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWCDWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCDWQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWCDWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:16:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51158
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932224AbWCDWQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:16:50 -0500
Date: Sat, 04 Mar 2006 14:16:43 -0800 (PST)
Message-Id: <20060304.141643.04633220.davem@davemloft.net>
To: gene.heskett@verizononline.net, gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603041705.41990.gene.heskett@verizon.net>
References: <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr>
	<20060304.134144.122314124.davem@davemloft.net>
	<200603041705.41990.gene.heskett@verizon.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Heskett <gene.heskett@verizon.net>
Date: Sat, 04 Mar 2006 17:05:41 -0500

> On Saturday 04 March 2006 16:41, David S. Miller wrote:
> >From: Jan Engelhardt <jengelh@linux01.gwdg.de>
> >Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
> >
> >> Does this buy the normal standard desktop user anything?
> >
> >Absolutely, it optimizes end-node performance.
> 
> Is this quantifiable?, and does it only apply to Intel?

It applies to whoever has a DMA engine in their computer.

What people need to understand is that this is putting the
optimization in the right place, at the end nodes.  This is about as
old an internet architecting fundamental as you can get, keep the hard
work off the routers and intermediate nodes, and put it on the end
systems.

Intel has done performance numbers, and I'm sure they will post them
at the appropriate time.
