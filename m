Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271700AbRHUOaG>; Tue, 21 Aug 2001 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271701AbRHUO3t>; Tue, 21 Aug 2001 10:29:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12958 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271700AbRHUO3h>;
	Tue, 21 Aug 2001 10:29:37 -0400
Date: Tue, 21 Aug 2001 07:29:44 -0700 (PDT)
Message-Id: <20010821.072944.23015940.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ZCJM-0007w6-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15ZCJM-0007w6-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 21 Aug 2001 15:15:20 +0100 (BST)

   > You might as well remove all of these drivers in whole, as they are
   > basically non-functional without the accompanying firmware.
   
   Now you are talking complete and total crap. I tested this firmware removal
   stuff on a QlogicFC 2100 card. It works fine

It works fine in your x86-centric world, on your x86 BIOS card.
It breaks on every UltraSparc system I have with qlogic,fc onboard.
One powercycle or PCI master abort, and I am unbootable.

And I am the one talking crap? :-)

Later,
David S. Miller
davem@redhat.com
