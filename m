Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbRBZOep>; Mon, 26 Feb 2001 09:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbRBZObJ>; Mon, 26 Feb 2001 09:31:09 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130357AbRBZOah>;
	Mon, 26 Feb 2001 09:30:37 -0500
Message-ID: <20010226084403.10459.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico@patrec.com>
Subject: Re: 64GB option broken in 2.4.2
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 26 Feb 2001 02:44:03 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14XCWa-0000Hc-00@the-village.bc.nu> from "Alan Cox" at Feb 26, 1 01:32:27 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hypthesis#2 The bounce buffer code in the Linus tree is known to be
> imperfect. Does 2.4.2ac3 do the same ?
> 
No improvement.  (In fact, 2.4.2ac3 breaks 3ware IDE RAID support.)

While operating this Thunder 2500 (Tyan motherboard, ServerWorks chipset)
is like walking on a minefield, the problem I see with 2.4.2 64GB option
feels generic.  I'll go out on a limb, and claim that anyone with more
than 1GB can reproduce this CPU spin.
