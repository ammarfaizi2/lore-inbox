Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTI3GdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3GdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:33:01 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7867 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263135AbTI3Gc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:32:29 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: acme@conectiva.com.br, bunk@fs.tum.de, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030929221712.51e6c27b.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de>
	 <20030929003229.GM1039@conectiva.com.br>
	 <1064826174.29569.13.camel@hades.cambridge.redhat.com>
	 <20030929221712.51e6c27b.davem@redhat.com>
Message-Id: <1064903505.6154.157.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 07:31:45 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 22:17 -0700, David S. Miller wrote:
> On Mon, 29 Sep 2003 10:02:55 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > The underlying point being that your static kernel should not change if
> > you change an option from 'n' to 'm'. It should only affect the kernel
> > image if you change options to/from 'y'.
> 
> I totally disagree, what ipv6 is doing is perfectly fine.

Your right.

-- 
dwmw2


