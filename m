Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135504AbREHV4c>; Tue, 8 May 2001 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135521AbREHV4M>; Tue, 8 May 2001 17:56:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11956 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135504AbREHV4D>;
	Tue, 8 May 2001 17:56:03 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.27479.707679.544048@pizda.ninka.net>
Date: Tue, 8 May 2001 14:55:35 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), zaitcev@redhat.com (Pete Zaitcev),
        david-b@pacbell.net, johannes@erdfelt.com, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: pci_pool_free from IRQ
In-Reply-To: <E14xFD5-0000hh-00@the-village.bc.nu>
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
	<E14xFD5-0000hh-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > I suspect we should fix the documentation (and if need be the code) to reflect
 > the fact that you have to be completely out of your tree to handle device 
 > removal in the irq handler

Agreed.

Later,
David S. Miller
davem@redhat.com
