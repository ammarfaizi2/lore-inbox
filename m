Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbQKPNKW>; Thu, 16 Nov 2000 08:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQKPNKN>; Thu, 16 Nov 2000 08:10:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55443 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129747AbQKPNKG>;
	Thu, 16 Nov 2000 08:10:06 -0500
Date: Thu, 16 Nov 2000 04:22:36 -0800
Message-Id: <200011161222.EAA18278@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hch@caldera.de
CC: willy@meta-x.org, linux-kernel@vger.kernel.org, wtarreau@yahoo.fr
In-Reply-To: <200011161213.NAA27334@ns.caldera.de> (message from Christoph
	Hellwig on Thu, 16 Nov 2000 13:13:37 +0100)
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
In-Reply-To: <200011161213.NAA27334@ns.caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 16 Nov 2000 13:13:37 +0100
   From: Christoph Hellwig <hch@caldera.de>

   Would you accept such a change for 2.5?

Sure, that sounds nice.

Actually, one of the possible "grand plans" for 2.5 is a unified
"struct device".  I don't know what will actually happen here.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
