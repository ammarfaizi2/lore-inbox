Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUHIGlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUHIGlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 02:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHIGlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 02:41:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:662 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266170AbUHIGlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 02:41:52 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Wu Jian Feng <jianfengw@mobilesoft.com.cn>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-mtd@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809015950.GA20408@mobilesoft.com.cn>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
	 <20040808061206.GA5417@mobilesoft.com.cn>
	 <1091962414.1438.977.camel@imladris.demon.co.uk>
	 <20040809015950.GA20408@mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1092033702.1438.2169.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 07:41:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 09:59 +0800, Wu Jian Feng wrote:
> I see the same thing as rmk, used both gcc-3.3.2 and 3.4.0,
> on a OMAP730 (arm926ejs).

Russell hasn't been able to reproduce it. Can you? If so, how -- and can
you do same with CONFIG_JFFS2_FS_DEBUG=1 and show me the output?

-- 
dwmw2


