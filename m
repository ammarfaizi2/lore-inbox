Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWH1Hqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWH1Hqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWH1Hqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:46:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932464AbWH1Hqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:46:48 -0400
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <200608280941.10965.arnd@arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
	 <20060827215637.555365000@klappe.arndb.de> <p73ac5pe2iy.fsf@verdi.suse.de>
	 <200608280941.10965.arnd@arndb.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 09:46:17 +0200
Message-Id: <1156751177.3034.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 09:41 +0200, Arnd Bergmann wrote:
> On Monday 28 August 2006 09:35, Andi Kleen wrote:
> > I would prefer to keep them on i386/x86-64 at least because
> > a lot of my test programs are using them.
> > 
> Hmm, maybe we should have an asm-generic/unistd.h then
> containing something like


we or the (g)libc headers ?



