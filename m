Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbTHCU6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTHCU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:58:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43929 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270335AbTHCU4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:56:23 -0400
Subject: Re: TOE brain dump
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nivedita Singhvi <niv@us.ibm.com>,
       Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F2C891B.7080004@candelatech.com>
References: <20030802140444.E5798@almesberger.net>
	 <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com>
	 <3F2C891B.7080004@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059943933.31901.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 21:52:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 05:01, Ben Greear wrote:
> Jeff Garzik wrote:
> 
> > So, fix the other end of the pipeline too, otherwise this fast network 
> > stuff is flashly but pointless.  If you want to serve up data from disk, 
> > then start creating PCI cards that have both Serial ATA and ethernet 
> > connectors on them :)  Cut out the middleman of the host CPU and host 
> 
> I for one would love to see something like this, and not just Serial ATA..
> but maybe 8x Serial ATA and RAID :)

There is a protocol floating around for ATA over ethernet, no TCP layer
or nasty latency eating complexities in the middle

