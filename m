Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUIIXZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUIIXZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIIXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:25:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:63371 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268084AbUIIXW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:22:28 -0400
Subject: Re: netwinder or ARM build platform
From: David Woodhouse <dwmw2@infradead.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409091759.i89HxHI2023135@work.bitmover.com>
References: <200409091759.i89HxHI2023135@work.bitmover.com>
Content-Type: text/plain
Message-Id: <1094772143.9144.42.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 10 Sep 2004 00:22:23 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 10:59 -0700, Larry McVoy wrote:
> BK found another bad hard drive today, on our netwinder.  The disk is dieing
> badly unfortunately and I don't have installation media for this beast.
> I suspect I can go find it but does anyone know of a faster build platform
> for arm?  Russell uses bk on arms (no kidding, that's amazing) and so we
> continue to support it but that netwinder is just amazingly slow.  If there
> is a faster platform we want one.

TBH I'd suggest cross-building and testing in qemu-arm. Assuming
qemu-arm is actually working now.

-- 
dwmw2


