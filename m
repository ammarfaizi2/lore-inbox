Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbREUHxm>; Mon, 21 May 2001 03:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261895AbREUHxc>; Mon, 21 May 2001 03:53:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261894AbREUHxa>;
	Mon, 21 May 2001 03:53:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.51569.744590.398000@pizda.ninka.net>
Date: Mon, 21 May 2001 00:53:21 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrewm@uow.edu.au (Andrew Morton), andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <E151kPk-0003S9-00@the-village.bc.nu>
In-Reply-To: <15112.26793.768442.418184@pizda.ninka.net>
	<E151kPk-0003S9-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > And how do you propose to implemnt cache coherent pci allocations
 > on machines which lack the ability to have pages coherent between
 > I/O and memory space ?

Pages, being in memory space, are never in I/O space.

Maybe I don't understand the situation.

Later,
David S. Miller
davem@redhat.com
