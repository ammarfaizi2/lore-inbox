Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264086AbRFNVpm>; Thu, 14 Jun 2001 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264087AbRFNVpc>; Thu, 14 Jun 2001 17:45:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21172 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264086AbRFNVpZ>;
	Thu, 14 Jun 2001 17:45:25 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.12402.102143.400686@pizda.ninka.net>
Date: Thu, 14 Jun 2001 14:45:22 -0700 (PDT)
To: Kip Macy <kmacy@netapp.com>
Cc: nick@snowman.net, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <Pine.GSO.4.10.10106141439040.6619-100000@orbit-fe.eng.netapp.com>
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net>
	<Pine.GSO.4.10.10106141439040.6619-100000@orbit-fe.eng.netapp.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kip Macy writes:
 > The acenic is definitely a kick-ass card. One's natural
 > inclination is to assume that an interface is obscured because 
 > it is second rate.

No, that's not my take.  My personal view is that 3com thinks that
allowing anyone to program the card like that was the biggest mistake
Alteon made with the Acenic.

Heh, "heavy intellectual property", it's a friggin' cpu that can
access the cards onboard memory and registers.  Sounds like just
another Acenic with a new PCI front-end to me.  If they are referring
to their IPSEC microcode when they say this, we don't care about that
just show us how to program the chip and we'll write our own :-)

Later,
David S. Miller
davem@redhat.com

