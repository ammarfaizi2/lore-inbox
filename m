Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbTGDJZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTGDJZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:25:20 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:64774 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265903AbTGDJZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:25:09 -0400
Date: Fri, 4 Jul 2003 10:39:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030704103927.A9740@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jari Ruusu <jari.ruusu@pp.inet.fi>, Andrew Morton <akpm@osdl.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl> <3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F04680D.B9703696@pp.inet.fi>; from jari.ruusu@pp.inet.fi on Thu, Jul 03, 2003 at 08:29:49PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 08:29:49PM +0300, Jari Ruusu wrote:
> Because loop-AES attempts to be compatible with structures in loop.h by not
> modifying loop.h at all. This is what the "no kernel sources patched or
> replaced" means. Breakage in loop.h breaks loop-AES, and I have to clean the
> mess.

So get your code merged.  Moaning about breaking out of tree code beeing
broken by changes when an in-kernel alternative eists doesn't help.

Either try to help improving what's in the tree or shut up.

