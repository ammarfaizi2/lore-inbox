Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTIAHzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTIAHzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:55:32 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63429 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262725AbTIAHz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:55:29 -0400
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: khc@pm.waw.pl, jes@trained-monkey.org, zaitcev@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831222233.1bd41f01.davem@redhat.com>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	 <20030818111522.A12835@devserv.devel.redhat.com>
	 <m33cfyt3x6.fsf@trained-monkey.org>
	 <1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	 <20030819095547.2bf549e3.davem@redhat.com>
	 <m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	 <m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	 <20030824060057.7b4c0190.davem@redhat.com>
	 <m365kmltdy.fsf@defiant.pm.waw.pl> <m365kex2rp.fsf@defiant.pm.waw.pl>
	 <20030830185007.5c61af71.davem@redhat.com>
	 <1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
	 <20030831222233.1bd41f01.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062402857.13087.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 08:54:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 06:22, David S. Miller wrote:
> > > I'm too busy to partake in this thread right now, sorry.
> > 
> > Then I suggest we remove the feature until 2.7 since nobody has time
> > to make it work in 2.6
> 
> The problem is that it works for the people it was created
> for, you're going to break things for them.

Unfortunately those people don't have time to finish the feature for 2.6
so its just going to cause bugs and accidents.


