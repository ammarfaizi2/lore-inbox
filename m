Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbTIAHwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTIAHwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:52:45 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:61893 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262724AbTIAHwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:52:43 -0400
Subject: Re: many IDE PCI cards "spurious 8259a" irq15(SMBus nforce2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Resident Boxholder <resid@boxho.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F52E0B3.2090001@boxho.com>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F4F5C9A.5BAA1542@vtc.edu.hk> <200308311443.55543.hpj@urpla.net>
	 <3F5287BC.48A1BCE6@vtc.edu.hk>  <3F52E0B3.2090001@boxho.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062402710.13083.2.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 08:51:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 07:01, Resident Boxholder wrote:
> cmd680 sii680 card doesn't work either. no error logged there, just hangs.

See the nForce & SI680 notes on the silicon image website, there are
some nforce boards that have problems with SI3112 at least

