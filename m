Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUBYVp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUBYVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:43:45 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44293 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261608AbUBYVme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:42:34 -0500
Date: Wed, 25 Feb 2004 21:42:28 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Otto Solares <solca@guug.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <20040225031553.GC17390@guug.org>
Message-ID: <Pine.LNX.4.44.0402252141110.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But if acceleration is not disabled you can't map the vmem and io regions.

That whole management needs to be reworked. Properly replaced with DRI.

> I am by no means a graphics expert like you or BenH but i think the mentioned
> above should express general userland needs.

I agree. Its getting there :-)
 

