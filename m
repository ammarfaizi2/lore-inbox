Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFGO7r>; Thu, 7 Jun 2001 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264138AbRFGO7i>; Thu, 7 Jun 2001 10:59:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:48564 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263476AbRFGO73>;
	Thu, 7 Jun 2001 10:59:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15135.25772.232947.584016@pizda.ninka.net>
Date: Thu, 7 Jun 2001 04:25:32 -0700 (PDT)
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Newsgroups: hometree.linux.kernel
In-Reply-To: <9fnjh0$d1c$1@forge.intermeta.de>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<15134.49211.159673.522020@pizda.ninka.net>
	<9fnjh0$d1c$1@forge.intermeta.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Henning P. Schmiedehausen writes:
 > And this is legal according to the "Kernel GPL, Linus Torvalds edition
 > (TM)" which says "any loadable module can be binary only". Not "only
 > loadable modules which are drivers". It may not be the intention but
 > it is the fact.

Where is this text you are quoting?

And I didn't say it's ok "only for drivers", I said "only when using
the module exported symbols found in Linus's kernel".

Later,
David S. Miller
davem@redhat.com
