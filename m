Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVFXE4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVFXE4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVFXE4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:56:38 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:47511 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S263052AbVFXEyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:54:54 -0400
Date: Thu, 23 Jun 2005 21:54:46 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050623215446.0e5ce93e.rdunlap@xenotime.net>
In-Reply-To: <20050623210638.53232e90.pj@sgi.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
	<20050621132204.1b57b6ba.akpm@osdl.org>
	<20050623210638.53232e90.pj@sgi.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 21:06:38 -0700 Paul Jackson wrote:

| > I wish people would absorb CodingStyle.
| 
| Some people just can't see it, Andrew.  Just like some people
| are tone deaf, some people don't notice minor variations in
| code spacing and layout, unless pointed out in tedious detail.
| 
| Not that I disagree with you ... ;).

I also agree.

The problem (for me at least) is that bad coding style needs
to be fixed before I can do a functional code review, so it
slows down the review cycle quite a bit.  Further, it's mostly
well-known what the requirements are, so there aren't very
many good excuses not to follow CodingStyle...

---
~Randy
