Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUHJNXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUHJNXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUHJNUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:20:24 -0400
Received: from [213.146.154.40] ([213.146.154.40]:52197 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265099AbUHJNQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:16:45 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Wu Jian Feng <jianfengw@mobilesoft.com.cn>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-mtd@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810005204.GA15714@mobilesoft.com.cn>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
	 <20040808061206.GA5417@mobilesoft.com.cn>
	 <1091962414.1438.977.camel@imladris.demon.co.uk>
	 <20040809015950.GA20408@mobilesoft.com.cn>
	 <1092057472.4383.5155.camel@hades.cambridge.redhat.com>
	 <20040810005204.GA15714@mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1092143795.4383.8195.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 10 Aug 2004 14:16:36 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 08:52 +0800, Wu Jian Feng wrote:
> On Mon, Aug 09, 2004 at 02:17:53PM +0100, David Woodhouse wrote:
> > 
> > Please could you test this....
> > 
> 
> It doesn't compile :-(

Doh. I committed that fix too -- I'll send it to Linus today. Thanks.

-- 
dwmw2

