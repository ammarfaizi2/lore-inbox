Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUBQRAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUBQRAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:00:40 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:38312 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266344AbUBQRAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:00:31 -0500
Date: Tue, 17 Feb 2004 10:00:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Cleanups for latest kgdb
Message-ID: <20040217170025.GA11679@smtp.west.cox.net>
References: <20040217103148.GA428@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217103148.GA428@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 11:31:49AM +0100, Pavel Machek wrote:
> Hi!
> 
> Some small cleanups... Relative to latest kgdb:
> 
> hexToLong is named strange and unlike anything else. Renamed to
> hex2long.

Put in the version I'll send to Andrew shortly.

> Whitespace in kgdb_8250.c is "interesting". Fixed.

Already Lindent'ed the file.

> In asm-i386/processor.h you insert blank line. This kills it.

And hit / fixed this as well.

-- 
Tom Rini
http://gate.crashing.org/~trini/
