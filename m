Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUBYVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUBYVnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:43:41 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:46853 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261616AbUBYVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:43:08 -0500
Date: Wed, 25 Feb 2004 21:43:02 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Otto Solares <solca@guug.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <Pine.GSO.4.58.0402251240140.24169@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0402252142490.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't expect an app that mmap()s mmio to read/write from /dev/fb* at the same
> time. So I see no problem disabling accelerated read/write while mmio is
> mapped.

Good point!

