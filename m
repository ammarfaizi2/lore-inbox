Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbUKPRxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUKPRxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKPRvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:51:44 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12301 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262070AbUKPRv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:51:27 -0500
Subject: Re: [PATCH] jffs2: printk arg. type warning
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <419906C6.9020709@osdl.org>
References: <419906C6.9020709@osdl.org>
Content-Type: text/plain
Message-Id: <1100627479.8191.6985.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 16 Nov 2004 17:51:20 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-15 at 11:43 -0800, Randy.Dunlap wrote:
> + printk(KERN_WARNING "jffs2_g_c_deletion_dirent(): Short read (%zd not %ud) reading header from obsolete node at %08x\n",fix printk argument type warning:

'%ud'?

-- 
dwmw2

