Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVDGKLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVDGKLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVDGKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:11:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9127 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262413AbVDGKLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:11:46 -0400
Subject: Re: Kernel SCM saga..
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050407105531.A19605@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <20050407015019.4563afe0.akpm@osdl.org>
	 <1112865919.24487.442.camel@hades.cambridge.redhat.com>
	 <20050407105531.A19605@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 11:11:38 +0100
Message-Id: <1112868699.24487.452.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 10:55 +0100, Russell King wrote:
> Thinking about it a bit, if you're asking Linus to pull your tree,
> Linus would then have to extract the individual change sets as patches
> to put into his new fangled patch management system.  Is that a
> reasonable expectation?

I don't know if it's a reasonable expectation; that's why I'm asking.

I could live with having to export everything to patches; it's not so
hard. It's just that if the export to whatever ends up replacing BK can
be done in a way (or at a time) which allows the existing forest of BK
trees to be pulled from one last time, that may save a fair amount of
work all round, so I thought it was worth mentioning.

-- 
dwmw2

