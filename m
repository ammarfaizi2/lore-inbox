Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVEMUrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVEMUrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVEMUdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:33:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:44775 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262492AbVEMUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:09:52 -0400
X-Authenticated: #20450766
Date: Fri, 13 May 2005 20:50:18 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Sander <sander@humilis.net>, David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: iSCSI vs. NBD (was Re: ata over ethernet question)
In-Reply-To: <1115923927.5042.18.camel@mulgrave>
Message-ID: <Pine.LNX.4.60.0505132040400.8052@poirot.grange>
References: <1416215015.20050504193114@dns.toxicfilms.tv> 
 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>  <1104082357.20050504231722@dns.toxicfilms.tv>
  <1115305794.3071.5.camel@dhollis-lnx.sunera.com>  <20050507150538.GA800@favonius>
  <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <1115923927.5042.18.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, James Bottomley wrote:

> However, there is room for improvement in nbd, notably the handling of
> packet commands, which looks to be eminently doable in the current
> infrastructure (this would basically make nbd a replicator for the linux
> block system, and would probably necessitate some client side changes to
> achieve).  If you have any thoughts in this direction, you could drop an
> email to the maintainer.

Thanks, James

I'll try to get some (thoughts):-) BTW, who is the maintainer of nbd? No 
one in MAINTAINERS, in nbd.c only
 * Copyright 1997-2000 Pavel Machek <pavel@ucw.cz>
 * Parts copyright 2001 Steven Whitehouse <steve@chygwyn.com>
Is it Pavel then?

Thanks
Guennadi
---
Guennadi Liakhovetski

