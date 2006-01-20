Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWATIdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWATIdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWATIdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:33:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750738AbWATIdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:33:53 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060119155933.GX4213@suse.de>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <1137664692.8471.21.camel@localhost.localdomain>
	 <20060119155933.GX4213@suse.de>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 21:33:15 +1300
Message-Id: <1137745995.30084.201.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 16:59 +0100, Jens Axboe wrote:
> I think the CodingStyle suggestion of 80 chars is just fine. I try to
> stay within that, and I mostly succeed. The occasional over-the-line is
> far better than advocation >> 80 chars per line imho.

I agree. It's that "occasional over-the-line" which Andrew is mucking
about with in the patch which started this thread; the case where it
makes _sense_ to let it go over 80 characters rather than wrapping it.

-- 
dwmw2

