Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUAEXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUAEXek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:34:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:39432 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266019AbUAEXeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:34:04 -0500
Date: Mon, 5 Jan 2004 23:33:59 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, <claas@rootdir.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <1072845181.716.9.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401052333390.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ben, if you could shoot me over a copy of the current linux-fbdev tree that
> > might help things along a bit.
> 
> linux-fbdev is at bk://fbdev.bkbits.net/fbdev-2.5
> 
> Some things in there are too crappy though, like the whole gfx-client
> stuff, I suggest you don't merge as-is. I will start sending you
> patches tomorrow hopefully.

Is the gfx-client stuff the only issue for you?


