Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL1XUs>; Thu, 28 Dec 2000 18:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbQL1XUj>; Thu, 28 Dec 2000 18:20:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20864 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129828AbQL1XUL>;
	Thu, 28 Dec 2000 18:20:11 -0500
Date: Thu, 28 Dec 2000 14:33:07 -0800
Message-Id: <200012282233.OAA01433@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001228231722.A24875@gruyere.muc.suse.de> (message from Andi
	Kleen on Thu, 28 Dec 2000 23:17:22 +0100)
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 28 Dec 2000 23:17:22 +0100
   From: Andi Kleen <ak@suse.de>

   Would you consider patches for any of these points? 

To me it seems just as important to make sure struct page is
a power of 2 in size, with the waitq debugging turned off this
is true for both 32-bit and 64-bit hosts last time I checked.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
