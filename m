Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264426AbRFOPhq>; Fri, 15 Jun 2001 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264427AbRFOPhh>; Fri, 15 Jun 2001 11:37:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55482 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264426AbRFOPh2>;
	Fri, 15 Jun 2001 11:37:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15146.11179.315190.615024@pizda.ninka.net>
Date: Fri, 15 Jun 2001 08:37:15 -0700 (PDT)
To: Pete Wyckoff <pw@osc.edu>
Cc: nick@snowman.net, Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <20010615111213.C2245@osc.edu>
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net>
	<Pine.LNX.4.21.0106141739140.16013-100000@ns>
	<15145.12192.199302.981306@pizda.ninka.net>
	<20010615111213.C2245@osc.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Wyckoff writes:
 > We're currently working on using both processors
 > of the Tigon in parallel.

It is my understanding that on the Tigon2, the second processor is
only for working around hw bugs in the DMA controller of the board and
cannot be used for other tasks.

WRT. tigon3, it was mentioned on this list that it is a pair of arm9
cpus, one for rx and one for tx.

Later,
David S. Miller
davem@redhat.com
