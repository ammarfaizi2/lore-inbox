Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFOQfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTFOQfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:35:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52752 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262363AbTFOQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:35:21 -0400
Date: Sun, 15 Jun 2003 09:48:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: mochel@osdl.org, <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>
Subject: Re: GFDL in the kernel tree
In-Reply-To: <20030615140758.A9390@infradead.org>
Message-ID: <Pine.LNX.4.44.0306150942280.8088-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Jun 2003, Christoph Hellwig wrote:
> 
> Folks, could we please only use GPL-compatible licenses in the kernel
> tree?

I'd agree. The GFDL is a disaster anyway.  You can't even fix bugs in the
documentation without having to change the title etc. There are much
better licenses around.

I'd say we just remove the files.

		Linus

