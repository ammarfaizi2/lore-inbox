Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVBXNU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVBXNU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVBXNU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:20:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34206 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262341AbVBXNUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:20:44 -0500
Subject: Re: [2.6 patch] remove drivers/mtd/maps/ich2rom.c
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mtd@lists.infradead.org, "Eric W. Biederman" <ebiederman@lnxi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050224111125.GH8651@stusta.de>
References: <20050224111125.GH8651@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 13:20:32 +0000
Message-Id: <1109251232.5420.55.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 12:11 +0100, Adrian Bunk wrote:
> drivers/mtd/maps/ich2rom.c is completely unused because it was renamed 
> to drivers/mtd/maps/ichxrom.c .
> 
> This patch removes the stale ich2rom.c file.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ack.

-- 
dwmw2

