Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRGSXOr>; Thu, 19 Jul 2001 19:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266171AbRGSXOi>; Thu, 19 Jul 2001 19:14:38 -0400
Received: from [216.101.162.242] ([216.101.162.242]:17794 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S266158AbRGSXOV>;
	Thu, 19 Jul 2001 19:14:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15191.27007.837441.266822@pizda.ninka.net>
Date: Thu, 19 Jul 2001 16:13:03 -0700 (PDT)
To: mostrows@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
In-Reply-To: <sb6r8vcg31q.fsf@slug.watson.ibm.com>
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
	<15189.2408.59953.395204@pizda.ninka.net>
	<sb6r8vcg31q.fsf@slug.watson.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Michal Ostrowski writes:
 > Alexey replied to my last post with some valuable comments and in
 > response I have a new patch (that goes on top of David Miller's patch
 > from yesterday).

Applied to my tree, thanks.

Later,
David S. Miller
davem@redhat.com
