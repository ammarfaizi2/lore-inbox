Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTHaMyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTHaMyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:54:04 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39097 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261368AbTHaMyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:54:02 -0400
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, jes@trained-monkey.org,
       zaitcev@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030830185007.5c61af71.davem@redhat.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 13:52:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 02:50, David S. Miller wrote:
> On 30 Aug 2003 23:18:50 +0200
> Krzysztof Halasa <khc@pm.waw.pl> wrote:
> 
> > David, any comments?
> 
> I'm too busy to partake in this thread right now, sorry.

Then I suggest we remove the feature until 2.7 since nobody has time
to make it work in 2.6

