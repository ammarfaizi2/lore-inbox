Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbQKGKNy>; Tue, 7 Nov 2000 05:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbQKGKNq>; Tue, 7 Nov 2000 05:13:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39556 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129845AbQKGKNa>;
	Tue, 7 Nov 2000 05:13:30 -0500
Date: Tue, 7 Nov 2000 01:58:28 -0800
Message-Id: <200011070958.BAA03175@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: R.E.Wolff@BitWizard.nl
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <200011070938.KAA03419@cave.bitwizard.nl>
	(R.E.Wolff@BitWizard.nl)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <200011070938.KAA03419@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 10:38:12 +0100 (MET)
   From: R.E.Wolff@BitWizard.nl (Rogier Wolff)

   David S. Miller wrote:
   > It is clear though, that something is messing with or corrupting the
   > packets.  One thing you might try is turning off TCP header
   > compression for the PPP link, does this make a difference?

   Try specifying "asyncmap 0xffffffff" too. 

I wonder how this is specified under win98 :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
