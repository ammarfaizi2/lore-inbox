Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVLGDPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVLGDPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVLGDPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:15:19 -0500
Received: from ozlabs.org ([203.10.76.45]:6592 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030299AbVLGDPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:15:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17302.21437.608048.64857@cargo.ozlabs.ibm.com>
Date: Wed, 7 Dec 2005 14:15:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Arnd Bergmann <arnd@arndb.de>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
In-Reply-To: <20051207022610.GI27946@ftp.linux.org.uk>
References: <20051206035220.097737000@localhost>
	<200512061118.19633.arnd@arndb.de>
	<1133869108.7968.1.camel@localhost>
	<200512061949.33482.arnd@arndb.de>
	<1133895947.3279.4.camel@localhost>
	<17301.65082.251692.675360@cargo.ozlabs.ibm.com>
	<1133905298.8027.13.camel@localhost>
	<17302.3696.364669.18755@cargo.ozlabs.ibm.com>
	<20051207022610.GI27946@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:

> FWIW, I think it's not a serious argument.  Interface changes => grep time.
> And that means grep over the tree anyway.

OK, well, where would you prefer the spufs code to go?

> That's solved by asking for review...

Could you review the spufs code (i.e. the patches posted by Arnd
recently to linuxppc64-dev@ozlabs.org) please?

Thanks,
Paul.
