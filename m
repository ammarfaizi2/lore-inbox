Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRK3W3I>; Fri, 30 Nov 2001 17:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRK3W26>; Fri, 30 Nov 2001 17:28:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53642 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281075AbRK3W2r>;
	Fri, 30 Nov 2001 17:28:47 -0500
Date: Fri, 30 Nov 2001 14:28:43 -0800 (PST)
Message-Id: <20011130.142843.31639840.davem@redhat.com>
To: jessica@twu.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the
 problem!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net>
In-Reply-To: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jessica Blank <jessica@twu.net>
   Date: Fri, 30 Nov 2001 08:35:35 -0600 (CST)

   	It is high time this problem is acknowledged and FIXED. I am
   forced to share a network with a bunch of NT servers, some of which get
   plenty of traffic-- enough so that they manage to crowd out my machine to
   the tune of 600ish ms ping times to the Linux box versus only **70**
   (!!!!!!) to the Windows box.

Changes to TCP and therefore anything having to do with
slow-start is not going to have any effect on ping times.

To me this sounds like a problem somewhere else, perhaps a driver
issue.
