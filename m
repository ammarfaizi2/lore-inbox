Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVISJBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVISJBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVISJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:01:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60132 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932391AbVISJBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:01:50 -0400
Date: Mon, 19 Sep 2005 10:01:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050919090145.GA15607@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, alan@lxorguk.ukuu.org.uk,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <432AFB44.9060707@namesys.com> <200509171415.50454.vda@ilport.com.ua> <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua> <20050918102658.GB22210@infradead.org> <b14e81f0050918102254146224@mail.gmail.com> <1127079524.8932.21.camel@localhost.localdomain> <432E4786.7010001@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E4786.7010001@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the roundless attacks, but I'm done.

I'll stop helping you to review stuff because it's just totally pointless,
you ignore most of the review anyway and start personal attacks.

Please find someone else to review your code for inclusion, that can stand
beeing attacked everytime they write an email.  Before you should probably
fix up various bits I wrote up and especialy make sure to get rid of
all duplication of generic I/O code or explain in detail why you need it
and fix your own implementations.

And next time you request review request and inclusion please use nicer
words than 'I request inclusion'.  There's no right to get code included
in the kernel tree, it's a honor.
