Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbUKUSKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUKUSKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbUKUSKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:10:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:38663 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261755AbUKUSKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:10:20 -0500
Subject: Re: [2.6 patch] MTD: some cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041121180150.GE2924@stusta.de>
References: <20041112135322.GB7707@stusta.de>
	 <1100629567.8191.6993.camel@hades.cambridge.redhat.com>
	 <20041121180150.GE2924@stusta.de>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 18:06:11 +0000
Message-Id: <1101060371.9988.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-21 at 19:01 +0100, Adrian Bunk wrote:
> > Again that's called from elsewhere.
> 
> The merging of the code calling it into the kernel is pending?

I believe so, yes.

-- 
dwmw2

