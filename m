Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQKPJdC>; Thu, 16 Nov 2000 04:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129872AbQKPJcx>; Thu, 16 Nov 2000 04:32:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129585AbQKPJcj>;
	Thu, 16 Nov 2000 04:32:39 -0500
Date: Thu, 16 Nov 2000 00:45:55 -0800
Message-Id: <200011160845.AAA10212@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: adam@yggdrasil.com
CC: willy@meta-x.org, linux-kernel@vger.kernel.org, wtarreau@yahoo.fr
In-Reply-To: <200011160833.AAA06880@adam.yggdrasil.com>
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
In-Reply-To: <200011160833.AAA06880@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I never ported it to the new PCI interfaces strictly because when
combined with SBUS it makes the driver initialization look really
sloppy.

Sorry, I don't like this change.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
