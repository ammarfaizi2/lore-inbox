Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274657AbRIYWgr>; Tue, 25 Sep 2001 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274655AbRIYWg2>; Tue, 25 Sep 2001 18:36:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65172 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274653AbRIYWgU>;
	Tue, 25 Sep 2001 18:36:20 -0400
Date: Tue, 25 Sep 2001 15:36:39 -0700 (PDT)
Message-Id: <20010925.153639.67883278.davem@redhat.com>
To: acmay@acmay.homeip.net
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] ipip.c & ip_gre.c (Add Tunnel return)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010925.153119.91756467.davem@redhat.com>
In-Reply-To: <20010925152628.A8042@ecam.san.rr.com>
	<20010925.153119.91756467.davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Tue, 25 Sep 2001 15:31:19 -0700 (PDT)
      
[ replying to self...]

   Hmmm, net/ipv6/sit.c already has the version you propose. :-)))
   Which one is correct?
   
   Alexey, what do you think?

Nevermind, it is clear that Andrew's patch is correct.
I've applied it, thanks.

Franks a lot,
David S. Miller
davem@redhat.com
