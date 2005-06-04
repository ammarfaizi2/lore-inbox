Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVFDRIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVFDRIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFDRIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 13:08:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:50845 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261390AbVFDRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 13:08:11 -0400
Date: Sat, 4 Jun 2005 19:07:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: Christoph Hellwig <hch@infradead.org>, schwab@suse.de,
       geert@linux-m68k.org, xiao@unice.fr, linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050604170757.GA10788@wohnheim.fh-wedel.de>
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de> <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be> <jer7fjeiae.fsf@sykes.suse.de> <Pine.LNX.4.62.0506031443000.16362@numbat.sonytel.be> <jed5r3eca8.fsf@sykes.suse.de> <20050603110436.3f801c65.rdunlap@xenotime.net> <20050604112825.GC19819@infradead.org> <20050604095811.2b6057d7.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050604095811.2b6057d7.rdunlap@xenotime.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 June 2005 09:58:11 -0700, randy_dunlap wrote:
> On Sat, 4 Jun 2005 12:28:25 +0100 Christoph Hellwig wrote:
> | 
> | Who claims that?
> 
> I dunno, but I'm not religious about it.
> 
> It's certainly not in CodingStyle, but I'm sure that I'm not just
> dreaming it (not making it up), I've seen it in emails from some
> maintainers, but searching for /unsigned/ generates too many hits
> to follow.

Which means, we can safely ignore this issue.  If "some maintainers"
really care, this thing will resurface.

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
