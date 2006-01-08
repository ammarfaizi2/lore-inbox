Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752625AbWAHOZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbWAHOZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbWAHOZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:25:05 -0500
Received: from canuck.infradead.org ([205.233.218.70]:7375 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1752625AbWAHOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:25:03 -0500
Subject: Re: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060108141430.GJ3774@stusta.de>
References: <20060107220702.GZ3774@stusta.de>
	 <1136678409.30348.26.camel@pmac.infradead.org>
	 <20060108002457.GE3774@stusta.de>
	 <1136680734.30348.34.camel@pmac.infradead.org>
	 <20060107174523.460f1849.akpm@osdl.org>
	 <1136724072.30348.66.camel@pmac.infradead.org>
	 <20060108125700.GI3774@stusta.de>
	 <1136725580.30348.69.camel@pmac.infradead.org>
	 <20060108141430.GJ3774@stusta.de>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 14:24:40 +0000
Message-Id: <1136730280.30348.78.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
X-Spam-Report: SpamAssassin version 3.0.4 on canuck.infradead.org summary:
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 15:14 +0100, Adrian Bunk wrote:
> This patch removes the wrong dependency of MTD_OBSOLETE_CHIPS on BROKEN 
> and marks the non-compiling MTD_AMDSTD and MTD_JEDEC drivers as BROKEN.

Looks better; thanks.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

-- 
dwmw2

