Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVA2QNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVA2QNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVA2QNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:13:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261525AbVA2QN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:13:29 -0500
Date: Sat, 29 Jan 2005 16:13:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129161325.GA1834@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org> <41FBAC44.9020502@drzeus.cx> <20050129155722.GA1320@infradead.org> <41FBB500.80805@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FBB500.80805@drzeus.cx>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 05:08:32PM +0100, Pierre Ossman wrote:
> For i386 and x86_64 it's defined as virt_to_phys in asm/io.h without any 
> #ifdef:s protecting it.

Not all the world is a PC

