Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263936AbRFEJS3>; Tue, 5 Jun 2001 05:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263939AbRFEJST>; Tue, 5 Jun 2001 05:18:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263936AbRFEJSB>;
	Tue, 5 Jun 2001 05:18:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.41887.927226.323445@pizda.ninka.net>
Date: Tue, 5 Jun 2001 02:17:19 -0700 (PDT)
To: <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.6-B2
In-Reply-To: <Pine.LNX.4.33.0106051059220.2633-200000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0106051059220.2633-200000@localhost.localdomain>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:
 >  - fixes module exports

Need to remove it from arch/ppc/kernel/ppc_ksyms.c too.

Later,
David S. Miller
davem@redhat.com
