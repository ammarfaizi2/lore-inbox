Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHGWAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHGWAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHGWAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:00:04 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46061 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264389AbUHGV77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:59:59 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20040807150458.E2805@flint.arm.linux.org.uk>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1091915997.1438.106.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 07 Aug 2004 22:59:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 15:04 +0100, Russell King wrote:
> Any ideas?  I haven't been able to reproduce (presumably because the
> erase succeeded, and we didn't need to re-erase again.)

Hmmm. None right now. Will take a closer look in the morning. Thanks for
the reports.

-- 
dwmw2


