Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135596AbREEXxH>; Sat, 5 May 2001 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135598AbREEXw5>; Sat, 5 May 2001 19:52:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135596AbREEXwp>;
	Sat, 5 May 2001 19:52:45 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15092.37426.648280.631914@pizda.ninka.net>
Date: Sat, 5 May 2001 16:52:18 -0700 (PDT)
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <3AF49617.1B3C48AF@candelatech.com>
In-Reply-To: <3AF4720F.35574FDD@candelatech.com>
	<15092.32371.139915.110859@pizda.ninka.net>
	<3AF49617.1B3C48AF@candelatech.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:
 > No idea, haven't tried to use netfilter.  With this patch, though,
 > it's as easy as:

I know, the problem is if some existing facility can be made
to do it, I'd rather it be done that way.

 > I have a setup that should be able to test some netfilter rules
 > if have some you want me to try....

I'd be interested in seeing netfilter rules or a new netfilter
kernel module which would do arpfilter as well.

Later,
David S. Miller
davem@redhat.com
