Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEaJ6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEaJ6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUEaJ6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:58:50 -0400
Received: from ozlabs.org ([203.10.76.45]:28627 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261752AbUEaJ6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:58:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16571.560.788601.739034@cargo.ozlabs.ibm.com>
Date: Mon, 31 May 2004 20:00:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rddunlap@osdl.org>, Danny ter Haar <dth@dth.net>,
       wa1ter@myrealbox.com, dth@ncc1701.cistron.net,
       Netdev <netdev@oss.sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
In-Reply-To: <20040531073211.GA4894@infradead.org>
References: <40B8A37D.1090802@myrealbox.com>
	<20040530134544.GE13111@fs.tum.de>
	<20040530143734.GA24627@dth.net>
	<20040530094120.61b22d2e.rddunlap@osdl.org>
	<40BA1F25.4080402@pobox.com>
	<20040530193706.GG13111@fs.tum.de>
	<Pine.LNX.4.58.0405301302020.1632@ppc970.osdl.org>
	<20040531073211.GA4894@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> Or have a gige chip that's crippled to do only 10/100, like the sungem
> on my ibook.

I think it is not that the sungem itself is crippled, rather that the
phy can only do 10/100.  I agree that the division between 10/100 and
gigabit ethernet is pretty useless.  I note that sungem didn't get put
in the gigabit list, for instance.

Paul.
