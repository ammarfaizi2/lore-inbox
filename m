Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRBZOec>; Mon, 26 Feb 2001 09:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130276AbRBZOc2>; Mon, 26 Feb 2001 09:32:28 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130259AbRBZO3f>;
	Mon, 26 Feb 2001 09:29:35 -0500
Subject: Re: 64GB option broken in 2.4.2
To: rico@patrec.com (Rico Tudor)
Date: Mon, 26 Feb 2001 11:14:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010226084403.10459.qmail@pc7.prs.nunet.net> from "Rico Tudor" at Feb 26, 2001 10:51:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XLbT-00011G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No improvement.  (In fact, 2.4.2ac3 breaks 3ware IDE RAID support.)

Curiouser and curiouser. The 3ware does have some known problems but you'd
see those equally on any SMP 1Ggig/4Gig/64Gig.

> While operating this Thunder 2500 (Tyan motherboard, ServerWorks chipset)
> is like walking on a minefield, the problem I see with 2.4.2 64GB option
> feels generic.  I'll go out on a limb, and claim that anyone with more
> than 1GB can reproduce this CPU spin.

In the case of 2.4.2ac I've not been able to, nor has the cerberus test suite
but that isnt remotely full coverage of all loads/behaviours or of all 
devices

