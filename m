Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbTFWNMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbTFWNKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:52 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:16057 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S266018AbTFWNDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:03:52 -0400
Date: Mon, 23 Jun 2003 06:17:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: John Bradford <john@grabjohn.com>
Cc: akpm@digeo.com, lm@bitmover.com, acme@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk, cw@f00f.org, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org, perex@suse.cz, phillips@arcor.de,
       torvalds@transmeta.com
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030623131731.GB6715@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	John Bradford <john@grabjohn.com>, akpm@digeo.com, lm@bitmover.com,
	acme@conectiva.com.br, alan@lxorguk.ukuu.org.uk, cw@f00f.org,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org, perex@suse.cz,
	phillips@arcor.de, torvalds@transmeta.com
References: <200306230740.h5N7eqUN000268@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306230740.h5N7eqUN000268@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 08:40:52AM +0100, John Bradford wrote:
> > If you think 3.[23] are slow, go back and compile with 2.7.2 - it's much
> > faster than the later versions.  I used to yank newer versions of gcc
> > off systems and put 2.7.2 on, I think it was close to 2x faster at
> > compilation and made no difference on BK performance.
> 
> Out of interest, have you tried compiling BK with tcc?

Nope.  I can if you want but I'll bet it doesn't support all our platforms.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
