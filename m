Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWEPPI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWEPPI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEPPI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:08:56 -0400
Received: from canuck.infradead.org ([205.233.218.70]:29870 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751208AbWEPPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:08:56 -0400
Subject: Re: jffs2 build fixes
From: David Woodhouse <dwmw2@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: jffs-dev@axis.com, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200605160755.38606.david-b@pacbell.net>
References: <200604010831.57875.david-b@pacbell.net>
	 <200605160755.38606.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 16 May 2006 16:08:49 +0100
Message-Id: <1147792129.3806.15.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 07:55 -0700, David Brownell wrote:
> I see that Andrew also got tired of such printk warnings, so his
> fix is now in the kernel.org tree ... here's a resend of this
> patch, updated against today's GIT by removing two of the printk
> warning fixes.

The other three printk watning fixes don't seem to apply any more
either. I've committed the __init and __exit bits though. Thanks.

-- 
dwmw2

