Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFDQ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFDQ63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFDQ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:58:28 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:41402 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261367AbVFDQ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:58:25 -0400
Date: Sat, 4 Jun 2005 09:58:11 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: schwab@suse.de, geert@linux-m68k.org, joern@wohnheim.fh-wedel.de,
       xiao@unice.fr, linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-Id: <20050604095811.2b6057d7.rdunlap@xenotime.net>
In-Reply-To: <20050604112825.GC19819@infradead.org>
References: <429EB537.4060305@unice.fr>
	<20050602084840.GA32519@wohnheim.fh-wedel.de>
	<Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
	<jer7fjeiae.fsf@sykes.suse.de>
	<Pine.LNX.4.62.0506031443000.16362@numbat.sonytel.be>
	<jed5r3eca8.fsf@sykes.suse.de>
	<20050603110436.3f801c65.rdunlap@xenotime.net>
	<20050604112825.GC19819@infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2005 12:28:25 +0100 Christoph Hellwig wrote:

| On Fri, Jun 03, 2005 at 11:04:36AM -0700, randy_dunlap wrote:
| > | Who deprecated it?
| > 
| > Not technically deprecated, just undesirable in the kernel sources.
| 
| Who claims that?

I dunno, but I'm not religious about it.

It's certainly not in CodingStyle, but I'm sure that I'm not just
dreaming it (not making it up), I've seen it in emails from some
maintainers, but searching for /unsigned/ generates too many hits
to follow.

---
~Randy
