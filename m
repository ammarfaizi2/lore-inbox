Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbTCYSf6>; Tue, 25 Mar 2003 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTCYSf6>; Tue, 25 Mar 2003 13:35:58 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:16398 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263205AbTCYSf5>; Tue, 25 Mar 2003 13:35:57 -0500
Date: Tue, 25 Mar 2003 18:47:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
In-Reply-To: <20030325182043.GH30908@suse.de>
Message-ID: <Pine.LNX.4.44.0303251846180.4568-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> irk, you replaced GFP_KERNEL with GFP_ATOMIC, and even unconditionally
> memset the return without even bothering to check if it succeeded or
> not.

Patch is dead. I'm working on a workqueue solution now.
 




