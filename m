Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTI3JRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTI3JRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:17:33 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:53198 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261245AbTI3JRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:17:32 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <1064913241.21551.69.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
	 <1064910398.21551.41.camel@hades.cambridge.redhat.com>
	 <20030930013025.697c786e.davem@redhat.com>
	 <1064911360.21551.49.camel@hades.cambridge.redhat.com>
	 <20030930015125.5de36d97.davem@redhat.com>
	 <1064913241.21551.69.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1064913445.21551.72.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 10:17:26 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 10:14 +0100, David Woodhouse wrote:
>  ∃ configuration option CONFIG_xxx :
> Changing CONFIG_xxx from 'n' to 'y' may change the resulting vmlinux.
> Changing CONFIG_xxx from 'n' to 'm' should not do so.

Bah. s/∃/∀/ of course. I should set up key bindings rather than having
to cut and paste with a mouse and insufficient caffeine :)

-- 
dwmw2

