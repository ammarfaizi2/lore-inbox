Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUDOVRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUDOVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:17:15 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:43657 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262915AbUDOVOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:14:55 -0400
Subject: Re: [PATCH 2.6.5] Add class support to drivers/mtd/mtdchar.c
From: David Woodhouse <dwmw2@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <207270000.1082063407@w-hlinder.beaverton.ibm.com>
References: <207270000.1082063407@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1082063698.2949.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1.dwmw2.1) 
Date: Thu, 15 Apr 2004 17:14:59 -0400
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 14:10 -0700, Hanna Linder wrote:
> This patch add sysfs class support to the MTD char device driver.
> I have verified it compiles and works. Please review or test with an 
> actual device if possible.

CONFIG_MTD_MTDRAM would let you test -- otherwise I'll look at it when I
get back to the office in a couple of weeks. Thanks.

-- 
dwmw2

