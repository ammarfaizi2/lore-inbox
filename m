Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLZE6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 23:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTLZE6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 23:58:54 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:14598 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264477AbTLZE6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 23:58:54 -0500
Date: Fri, 26 Dec 2003 03:09:24 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help: slab allocator and TLB
Message-ID: <20031226050923.GH14954@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
References: <20031226045103.42D163963@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226045103.42D163963@sitemail.everyone.net>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 25, 2003 at 08:51:02PM -0800, john moser escreveu:

> If I could impliment the hooks at just the right places, then pages in RAM
> could be compressed (ram increase at CPU cost) or encrypted (security against
> ram sniffing at CPU cost)

Perhaps you should look at these links?

http://lwn.net/Articles/37815/ "Looking forward to 2.7: compressed caching?"
http://linuxcompressed.sourceforge.net/
http://advogato.org/person/rcastro/

?

- Arnaldo
