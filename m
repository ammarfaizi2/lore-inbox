Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSCKCTZ>; Sun, 10 Mar 2002 21:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293493AbSCKCTP>; Sun, 10 Mar 2002 21:19:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293491AbSCKCTD>;
	Sun, 10 Mar 2002 21:19:03 -0500
Date: Sun, 10 Mar 2002 18:15:51 -0800 (PST)
Message-Id: <20020310.181551.102654203.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203110210.g2B2Akb25831@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
	<20020310.180456.91344522.davem@redhat.com>
	<200203110210.g2B2Akb25831@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Sun, 10 Mar 2002 19:10:46 -0700
   
   As Wayne said:
   > There is also the D-Link DGE-550T, a 64-bit/66MHz card starting at
   > US$80 (according to pricewatch).  It apparently uses a different
   > in-kernel driver, dl2k.o.
   
   So this is a different chip from the natsemi, right?

Yes.  And from a cursory glance the dl2k.o driver seems to even
be quite portable.  I haven't tested it out myself though.

I have no idea how this thing performs, but it does look like
it has a couple of hardware bugs.
