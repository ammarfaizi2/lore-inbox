Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUKJPST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUKJPST (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbUKJPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:15:21 -0500
Received: from [213.146.154.40] ([213.146.154.40]:54925 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261843AbUKJPNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:13:21 -0500
Subject: Re: bk-commits: diff -p?
From: David Woodhouse <dwmw2@infradead.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110150646.GA10537@work.bitmover.com>
References: <Pine.LNX.4.61.0411080940310.27771@anakin>
	 <20041108164302.GA489@work.bitmover.com>
	 <1100043712.21273.26.camel@baythorne.infradead.org>
	 <20041110150646.GA10537@work.bitmover.com>
Content-Type: text/plain
Message-Id: <1100099597.8191.180.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 10 Nov 2004 15:13:17 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 07:06 -0800, Larry McVoy wrote:
> OK, this is a hack but I think you can make it work.  Try moving
> `bk bin`/diff `bk bin`/diff.orig and putting in a shell 
> script for `bk bin`/diff that just adds $BK_GNU_DIFF_OPTS to the 
> options and execs `bk bin`/diff.orig

This would need to be done on kernel.org. Since it's a relatively low
priority, I think I'd rather wait for it to be fixed (if you're actually
going to fix it). 

I suppose I could install my own version of BK, but I'd rather just
wait, to be honest.

-- 
dwmw2

