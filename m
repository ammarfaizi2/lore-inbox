Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVDMKYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDMKYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDMKYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:24:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261291AbVDMKYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:24:12 -0400
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
In-Reply-To: <20050413094226.GP16489@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>
	 <1113311256.20848.47.camel@hades.cambridge.redhat.com>
	 <20050413094705.B1798@flint.arm.linux.org.uk>
	 <20050413085954.GA13251@pasky.ji.cz>
	 <1113384304.12012.166.camel@baythorne.infradead.org>
	 <20050413094226.GP16489@pasky.ji.cz>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 11:24:09 +0100
Message-Id: <1113387849.20848.122.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 11:42 +0200, Petr Baudis wrote:
> It's fine to share the objects database. If you want to share the
> directory cache, you are doing something wrong, though. What do you
> need it for?

I want to _not_ care which machine I happen to be on when I use git
repositories which live in my home directory. I want all operations to
just work, regardless of whether the shell I'm looking at happens to be
on a BE or a LE box.

> <...> Would this do what you want?

Sounds ideal.

-- 
dwmw2

