Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269918AbRHMHaH>; Mon, 13 Aug 2001 03:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269920AbRHMH35>; Mon, 13 Aug 2001 03:29:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43655 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269918AbRHMH3j>;
	Mon, 13 Aug 2001 03:29:39 -0400
Date: Mon, 13 Aug 2001 00:29:33 -0700 (PDT)
Message-Id: <20010813.002933.08320034.davem@redhat.com>
To: pmhahn@titan.lahn.de
Cc: gkade@bigbrother.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.8 compile error on sparc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108130822270.4372-100000@titan.lahn.de>
In-Reply-To: <Pine.LNX.4.31.0108121651250.8416-100000@tigger.unnerving.org>
	<Pine.LNX.4.33.0108130822270.4372-100000@titan.lahn.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
   Date: Mon, 13 Aug 2001 08:27:22 +0200 (CEST)

   Apply this patch which is from sparc64:
   
   --- linux-2.4.8/arch/sparc/mm/extable.c~	Fri Aug 10 19:57:54 2001
   +++ linux-2.4.8/arch/sparc/mm/extable.c	Mon Aug 13 08:22:54 2001

Already in 2.4.9-pre1, but that won't build for other reasons :-)

Later,
David S. Miller
davem@redhat.com
