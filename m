Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbRG0JqU>; Fri, 27 Jul 2001 05:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268803AbRG0JqK>; Fri, 27 Jul 2001 05:46:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23942 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267883AbRG0Jp7>;
	Fri, 27 Jul 2001 05:45:59 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.14426.240997.18614@pizda.ninka.net>
Date: Fri, 27 Jul 2001 02:46:02 -0700 (PDT)
To: <alex.buell@tahallah.demon.co.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cg14 frambuffer bug in 2.2.19 (and probably 2.4.x as well)
In-Reply-To: <Pine.LNX.4.33.0107261203241.366-100000@tahallah.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0107261203241.366-100000@tahallah.demon.co.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alex Buell writes:
 > I have a patch here that fixes an annoying bug in the cg14 framebuffer
 > driver on sparc32 platforms.

I've made this change in both my 2.2.x and 2.4.x trees.

Thanks a lot for hunting this down and making a fix.

Later,
David S. Miller
davem@redhat.com
