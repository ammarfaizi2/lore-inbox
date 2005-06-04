Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFDRLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFDRLa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFDRLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 13:11:30 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:19085 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261395AbVFDRL2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 13:11:28 -0400
Date: Sat, 4 Jun 2005 10:11:16 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: hch@infradead.org, schwab@suse.de, geert@linux-m68k.org, xiao@unice.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-Id: <20050604101116.1c016516.rdunlap@xenotime.net>
In-Reply-To: <20050604170757.GA10788@wohnheim.fh-wedel.de>
References: <429EB537.4060305@unice.fr>
	<20050602084840.GA32519@wohnheim.fh-wedel.de>
	<Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
	<jer7fjeiae.fsf@sykes.suse.de>
	<Pine.LNX.4.62.0506031443000.16362@numbat.sonytel.be>
	<jed5r3eca8.fsf@sykes.suse.de>
	<20050603110436.3f801c65.rdunlap@xenotime.net>
	<20050604112825.GC19819@infradead.org>
	<20050604095811.2b6057d7.rdunlap@xenotime.net>
	<20050604170757.GA10788@wohnheim.fh-wedel.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
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

On Sat, 4 Jun 2005 19:07:58 +0200 Jörn Engel wrote:

| On Sat, 4 June 2005 09:58:11 -0700, randy_dunlap wrote:
| > On Sat, 4 Jun 2005 12:28:25 +0100 Christoph Hellwig wrote:
| > | 
| > | Who claims that?
| > 
| > I dunno, but I'm not religious about it.
| > 
| > It's certainly not in CodingStyle, but I'm sure that I'm not just
| > dreaming it (not making it up), I've seen it in emails from some
| > maintainers, but searching for /unsigned/ generates too many hits
| > to follow.
| 
| Which means, we can safely ignore this issue.  If "some maintainers"
| really care, this thing will resurface.

Certainly.

---
~Randy
