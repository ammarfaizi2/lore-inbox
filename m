Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135609AbREIT17>; Wed, 9 May 2001 15:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREIT1z>; Wed, 9 May 2001 15:27:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18826 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135609AbREIT11>;
	Wed, 9 May 2001 15:27:27 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15097.39445.646189.834699@pizda.ninka.net>
Date: Wed, 9 May 2001 12:27:17 -0700 (PDT)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, johannes@erdfelt.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pci_pool_free from IRQ
In-Reply-To: <20010509143020.A22522@devserv.devel.redhat.com>
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
	<E14xFD5-0000hh-00@the-village.bc.nu>
	<15096.27479.707679.544048@pizda.ninka.net>
	<050701c0d80f$8f876ca0$6800000a@brownell.org>
	<15096.38109.228916.621891@pizda.ninka.net>
	<20010509143020.A22522@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Zaitcev writes:
 > A fix in pci remove does not fix regular processing.

I see.  Here is where I was confused.

Later,
David S. Miller
davem@redhat.com
