Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264072AbRFNViM>; Thu, 14 Jun 2001 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264077AbRFNVh4>; Thu, 14 Jun 2001 17:37:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14260 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264072AbRFNVhj>;
	Thu, 14 Jun 2001 17:37:39 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.11935.992736.767777@pizda.ninka.net>
Date: Thu, 14 Jun 2001 14:37:35 -0700 (PDT)
To: <nick@snowman.net>
Cc: Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <Pine.LNX.4.21.0106141731030.16013-100000@ns>
In-Reply-To: <Pine.GSO.4.10.10106141426170.6619-100000@orbit-fe.eng.netapp.com>
	<Pine.LNX.4.21.0106141731030.16013-100000@ns>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nick@snowman.net writes:
 > Erm, that is going to be a problem.  Crypto benifits more from open source
 > than any other market segment, and binary only drivers for linux are not
 > the way to go.  I guess I need to get rid of my 5-10 3cr990s and replace
 > them with someone else's product?

Many of us on the networking developer team believe that making the
programming interface to the cpus on the Tigon3 is the biggest mistake
3com could ever make.

What made the Acenic so ubiquitous and interesting was that you could
program the firmware on the board to do whatever you like.  They even
provided an entire firmware developer kit so you could hack on it.

So many useful projects came from this capability.

I feel dirty working on the Tigon3 driver for 2.4.x because of this.

Later,
David S. Miller
davem@redhat.com
