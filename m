Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757596AbWK1WTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596AbWK1WTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757618AbWK1WTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:19:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757596AbWK1WTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:19:52 -0500
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup()
	static
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061125191541.GH3702@stusta.de>
References: <20061125191541.GH3702@stusta.de>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 22:19:46 +0000
Message-Id: <1164752386.14595.24.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 20:15 +0100, Adrian Bunk wrote:
> This patch makes the needlessly global mtdpart_setup() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de> 

Applied; thanks.

-- 
dwmw2

