Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVDMJJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVDMJJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDMJJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:09:39 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:44173 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261273AbVDMJJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:09:34 -0400
Subject: Re: [ANNOUNCE] git-pasky-0.3
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
In-Reply-To: <425CE11C.8040306@zytor.com>
References: <20050409200709.GC3451@pasky.ji.cz>
	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>
	 <1113311256.20848.47.camel@hades.cambridge.redhat.com>
	 <20050413094705.B1798@flint.arm.linux.org.uk>
	 <20050413085954.GA13251@pasky.ji.cz>  <425CE11C.8040306@zytor.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 10:09:26 +0100
Message-Id: <1113383366.12012.156.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 02:06 -0700, H. Peter Anvin wrote:
> However, then I would also like to suggest replacing "unsigned int"
> and "unsigned short" with uint32_t and uint16_t, even though they're 
> consistent on all *current* Linux platforms.

Agreed.

-- 
dwmw2


