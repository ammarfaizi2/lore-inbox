Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757584AbWK1WTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbWK1WTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbWK1WTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:19:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757584AbWK1WTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:19:40 -0500
Subject: Re: [-mm patch] drivers/mtd/nand/rtc_from4.c: use lib/bitrev.c
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <20061122043811.GG5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061122043811.GG5200@stusta.de>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 22:19:36 +0000
Message-Id: <1164752376.14595.22.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 05:38 +0100, Adrian Bunk wrote:
> This patch converts drivers/mtd/nand/rtc_from4.c to use the new 
> lib/bitrev.c
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied; thanks.

-- 
dwmw2

