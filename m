Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSLIXWq>; Mon, 9 Dec 2002 18:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSLIXWq>; Mon, 9 Dec 2002 18:22:46 -0500
Received: from dp.samba.org ([66.70.73.150]:44673 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266363AbSLIXWp>;
	Mon, 9 Dec 2002 18:22:45 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15861.10107.602522.647253@argo.ozlabs.ibm.com>
Date: Tue, 10 Dec 2002 10:30:03 +1100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
References: <20021209154142.GA22901@nevyn.them.org>
	<Pine.LNX.4.44.0212090828460.3397-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Architecture maintainers, can you comment on how easy/hard it is to do the
> same thing on your architectures? I _assume_ it's trivial (akin to the
> three-liner register state change in i386/kernel/signal.c).

It's just as easy on PPC and PPC64 as on x86.

Paul.
